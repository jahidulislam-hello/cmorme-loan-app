import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:reverse_mortage_loan_app/core/exceptions/app_exceptions.dart';
import 'package:reverse_mortage_loan_app/features/notification/data/models/notification_model.dart';
import 'package:reverse_mortage_loan_app/features/notification/domain/usecases/get_notifications_usecase.dart';

class NotificationController extends GetxController {
  final GetNotificationsUseCase _getNotificationsUseCase;
  final _logger = Logger();

  NotificationController(this._getNotificationsUseCase);

  final notifications = <NotificationModel>[].obs;
  final isLoading = false.obs;

  /// Notifications grouped by date label: "Today", "Yesterday", or "3rd March".
  Map<String, List<NotificationModel>> get grouped {
    final result = <String, List<NotificationModel>>{};
    for (final item in notifications) {
      final label = _dateLabel(item.createdAt);
      result.putIfAbsent(label, () => []).add(item);
    }
    return result;
  }

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    isLoading.value = true;
    try {
      final result = await _getNotificationsUseCase();
      // Most recent first
      result.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      notifications.assignAll(result);
      _logger.i('Notifications fetched: ${result.length}');
    } on NoInternetException catch (e) {
      _logger.w('No internet fetching notifications: $e');
      Get.snackbar('No Internet', e.message, snackPosition: SnackPosition.BOTTOM);
    } on ServerException catch (e) {
      _logger.e('Server error fetching notifications: $e');
      Get.snackbar('Error', e.message, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      _logger.e('Unknown error fetching notifications: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // ─── Date helpers ──────────────────────────────────────────────────────────

  String _dateLabel(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final day = DateTime(date.year, date.month, date.day);

    if (day == today) return 'Today';
    if (day == today.subtract(const Duration(days: 1))) return 'Yesterday';
    return '${_ordinal(date.day)} ${_monthName(date.month)}';
  }

  String _ordinal(int day) {
    if (day >= 11 && day <= 13) return '${day}th';
    switch (day % 10) {
      case 1:
        return '${day}st';
      case 2:
        return '${day}nd';
      case 3:
        return '${day}rd';
      default:
        return '${day}th';
    }
  }

  static const _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  String _monthName(int month) => _months[month - 1];

  /// Formats DateTime as "9:05 AM"
  static String formatTime(DateTime dt) {
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour < 12 ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}
