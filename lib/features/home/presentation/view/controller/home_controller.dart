import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/core/exceptions/app_exceptions.dart';
import 'package:reverse_mortage_loan_app/core/services/cache_service.dart';
import 'package:reverse_mortage_loan_app/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:reverse_mortage_loan_app/features/recent_calculation/data/models/recent_calculation_response_model.dart';
import 'package:reverse_mortage_loan_app/features/recent_calculation/domain/usecases/delete_calculation_usecase.dart';
import 'package:reverse_mortage_loan_app/features/recent_calculation/domain/usecases/get_calculation_by_id_usecase.dart';
import 'package:reverse_mortage_loan_app/features/recent_calculation/domain/usecases/get_recent_calculations_usecase.dart';
import 'package:reverse_mortage_loan_app/shared/dialoges/delete_confirmation_dialog.dart';
import 'package:reverse_mortage_loan_app/shared/dialoges/delete_success_dialog.dart';


class HomeController extends GetxController {
  final GetProfileUseCase _getProfileUseCase;
  final GetRecentCalculationsUseCase _getRecentCalculationsUseCase;
  final DeleteCalculationUseCase _deleteCalculationUseCase;
  final GetCalculationByIdUseCase _getCalculationByIdUseCase;
  final _logger = Logger();

  HomeController({
    required GetProfileUseCase getProfileUseCase,
    required GetRecentCalculationsUseCase getRecentCalculationsUseCase,
    required DeleteCalculationUseCase deleteCalculationUseCase,
    required GetCalculationByIdUseCase getCalculationByIdUseCase,
  })  : _getProfileUseCase = getProfileUseCase,
        _getRecentCalculationsUseCase = getRecentCalculationsUseCase,
        _deleteCalculationUseCase = deleteCalculationUseCase,
        _getCalculationByIdUseCase = getCalculationByIdUseCase;

  final userName = ''.obs;
  final isProfileLoading = true.obs;

  final calculations = <RecentCalculationItemModel>[].obs;
  final isCalculationLoading = true.obs;

  RecentCalculationItemModel? get latestCalculation =>
      calculations.isNotEmpty ? calculations.first : null;

  @override
  void onInit() {
    super.onInit();
    _fetchProfile();
    _fetchLatestCalculation();
  }

  static const _userNameCacheKey = 'cached_user_name';

  Future<void> _fetchProfile() async {
    isProfileLoading.value = true;
    try {
      final profile = await _getProfileUseCase();
      userName.value = profile.firstName;
      await CacheService().put(_userNameCacheKey, profile.firstName);
      _logger.i('Profile fetched: ${profile.firstName}');
    } on NoInternetException catch (e) {
      _logger.w('No internet fetching profile — loading from cache: $e');
      final cached = CacheService().get<String>(_userNameCacheKey);
      if (cached != null) userName.value = cached;
    } on ServerException catch (e) {
      _logger.e('Server error fetching profile: $e');
    } catch (e) {
      _logger.e('Unknown error fetching profile: $e');
    } finally {
      isProfileLoading.value = false;
    }
  }

  Future<void> _fetchLatestCalculation() async {
    isCalculationLoading.value = true;
    try {
      final response = await _getRecentCalculationsUseCase(limit: 10);
      calculations.assignAll(response.data);
      _logger.i('Calculations fetched: ${calculations.length}');
    } on NoInternetException catch (e) {
      _logger.w('No internet fetching calculation: $e');
    } on ServerException catch (e) {
      _logger.e('Server error fetching calculation: $e');
    } catch (e) {
      _logger.e('Unknown error fetching calculation: $e');
    } finally {
      isCalculationLoading.value = false;
    }
  }

  static final _dateFmt = DateFormat('dd MMM yyyy');
  static final _numFmt = NumberFormat('#,##0.##');

  String formatDate(DateTime date) => _dateFmt.format(date);

  String formatAmount(double amount) => _numFmt.format(amount);

  String tagLabel(String financeType) =>
      financeType == 'reverse_purchase' ? 'Reverse for Purchase' : 'Reverse Refinance';

  void onReturnToHome() => _fetchLatestCalculation();

  void onNotification() => Get.toNamed(RouteNames.notification);

  void onReverseRefinance() =>
      Get.toNamed(RouteNames.reverseRefinance, arguments: {'type': 'refinance'});

  void onReverseForPurchase() =>
      Get.toNamed(RouteNames.reverseRefinance, arguments: {'type': 'purchase'});

  void onReverseMortgageFAQ() => Get.toNamed(RouteNames.faqQuestions);

  Future<void> onSeeAllCalculations() async {
    await Get.toNamed(RouteNames.recentCalculation);
    _fetchLatestCalculation();
  }

  Future<void> onViewDetails() async {
    final item = latestCalculation;
    if (item == null) return;
    try {
      final detail = await _getCalculationByIdUseCase(item.id);
      _logger.i('Fetched calculation detail: ${item.id}');
      Get.toNamed(RouteNames.loanDetails, arguments: detail);
    } on NoInternetException catch (e) {
      _logger.w('No internet fetching detail: $e');
      Get.snackbar('No Internet', e.message);
    } on TimeoutException catch (e) {
      _logger.w('Timeout fetching detail: $e');
      Get.snackbar('Timeout', 'Server took too long. Please try again.');
    } on ServerException catch (e) {
      _logger.e('Server error fetching detail: $e');
      Get.snackbar('Error', e.message);
    } catch (e) {
      _logger.e('Unknown error fetching detail: $e');
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    }
  }

  void onDeleteCalculation() {
    final item = latestCalculation;
    if (item == null) return;
    Get.dialog(
      DeleteConfirmationDialog(
        onDelete: () async {
          Get.back();
          try {
            await _deleteCalculationUseCase(item.id);
            calculations.removeAt(0);
            _logger.i('Deleted calculation: ${item.id}');
            Get.dialog(
              const DeleteSuccessDialog(),
              barrierColor: Colors.white24,
            );
          //  Get.find<HistoryController>().fetchCalculations(); // comment out to avoid unnecessary api call
         //   Get.find<HistoryController>().removeCalculationById(item.id);
          } on NoInternetException catch (e) {
            _logger.w('No internet during delete: $e');
            Get.snackbar('No Internet', e.message);
          } on TimeoutException catch (e) {
            _logger.w('Timeout during delete: $e');
            Get.snackbar('Timeout', 'Server took too long. Please try again.');
          } on ServerException catch (e) {
            _logger.e('Server error during delete: $e');
            Get.snackbar('Error', e.message);
          } catch (e) {
            _logger.e('Unknown error during delete: $e');
            Get.snackbar('Error', 'Something went wrong. Please try again.');
          }
        },
      ),
      barrierColor: Colors.white24,
    );
  }
}
