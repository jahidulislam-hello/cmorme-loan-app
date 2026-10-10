import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/core/exceptions/app_exceptions.dart';
import 'package:reverse_mortage_loan_app/features/recent_calculation/data/models/recent_calculation_response_model.dart';
import 'package:reverse_mortage_loan_app/features/recent_calculation/domain/usecases/delete_calculation_usecase.dart';
import 'package:reverse_mortage_loan_app/features/recent_calculation/domain/usecases/get_calculation_by_id_usecase.dart';
import 'package:reverse_mortage_loan_app/features/recent_calculation/domain/usecases/get_recent_calculations_usecase.dart';
import 'package:reverse_mortage_loan_app/shared/dialoges/delete_confirmation_dialog.dart';
import 'package:reverse_mortage_loan_app/shared/dialoges/delete_success_dialog.dart';
import 'package:reverse_mortage_loan_app/shared/dialoges/filter_dialog.dart';
import 'package:intl/intl.dart';

class HistoryController extends GetxController {
  final GetRecentCalculationsUseCase _getRecentCalculationsUseCase;
  final DeleteCalculationUseCase _deleteCalculationUseCase;
  final GetCalculationByIdUseCase _getCalculationByIdUseCase;
  final _logger = Logger();

  HistoryController({
    required GetRecentCalculationsUseCase getRecentCalculationsUseCase,
    required DeleteCalculationUseCase deleteCalculationUseCase,
    required GetCalculationByIdUseCase getCalculationByIdUseCase,
  })  : _getRecentCalculationsUseCase = getRecentCalculationsUseCase,
        _deleteCalculationUseCase = deleteCalculationUseCase,
        _getCalculationByIdUseCase = getCalculationByIdUseCase;

  final searchController = TextEditingController();
  late final ScrollController scrollController;

  final calculations = <RecentCalculationItemModel>[].obs;
  final isLoading = false.obs;
  final isLoadingMore = false.obs;

  int _currentPage = 1;
  int _totalPages = 1;
  bool get _hasMore => _currentPage < _totalPages;

  // null = no filter, 'reverse_refinance' or 'reverse_purchase'
  final selectedFilter = Rxn<String>();
  final selectedDate = Rxn<DateTime>();

  List<RecentCalculationItemModel> get filteredCalculations {
    return calculations.where((c) {
      final matchesType = selectedFilter.value == null ||
          c.financeType == selectedFilter.value;
      final matchesDate = selectedDate.value == null ||
          (c.createdAt.year == selectedDate.value!.year &&
              c.createdAt.month == selectedDate.value!.month &&
              c.createdAt.day == selectedDate.value!.day);
      return matchesType && matchesDate;
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
    fetchCalculations();
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        !isLoadingMore.value &&
        _hasMore) {
      _loadNextPage();
    }
  }

  Future<void> fetchCalculations() async {
    isLoading.value = true;
    _currentPage = 1;
    try {
      final response = await _getRecentCalculationsUseCase(limit: 10, page: 1);
      calculations.assignAll(response.data);
      _totalPages = response.pagination.totalPage;
      _logger.i('History: fetched ${calculations.length} calculations (page 1 of $_totalPages)');
    } on NoInternetException catch (e) {
      _logger.w('History: no internet — showing cached data: $e');
    } on TimeoutException catch (e) {
      _logger.w('Timeout: $e');
      Get.snackbar('Timeout', 'Server took too long. Please try again.');
    } on ServerException catch (e) {
      _logger.e('Server error: $e');
      Get.snackbar('Error', e.message);
    } catch (e) {
      _logger.e('Unknown error: $e');
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadNextPage() async {
    isLoadingMore.value = true;
    final nextPage = _currentPage + 1;
    try {
      final response = await _getRecentCalculationsUseCase(limit: 10, page: nextPage);
      calculations.addAll(response.data);
      _currentPage = nextPage;
      _logger.i('History: loaded page $nextPage — total ${calculations.length} items');
    } on NoInternetException catch (e) {
      _logger.w('No internet loading page $nextPage: $e');
      Get.snackbar('No Internet', 'Cannot load more.', snackPosition: SnackPosition.BOTTOM);
    } on TimeoutException catch (e) {
      _logger.w('Timeout loading page $nextPage: $e');
    } on ServerException catch (e) {
      _logger.e('Server error loading page $nextPage: $e');
    } catch (e) {
      _logger.e('Unknown error loading page $nextPage: $e');
    } finally {
      isLoadingMore.value = false;
    }
  }

  void removeCalculationById(String id) {
    calculations.removeWhere((c) => c.id == id);
  }

  static final _dateFmt = DateFormat('dd MMM yyyy');
  static final _numFmt = NumberFormat('#,##0.##');

  String formatDate(DateTime date) => _dateFmt.format(date);

  String formatAmount(double amount) => _numFmt.format(amount);

  String tagLabel(String financeType) =>
      financeType == 'reverse_purchase' ? 'Reverse for Purchase' : 'Reverse Refinance';

  Future<void> onViewDetails(int index) async {
    final id = filteredCalculations[index].id;
    try {
      final item = await _getCalculationByIdUseCase(id);
      _logger.i('History: fetched detail for $id');
      Get.toNamed(RouteNames.loanDetails, arguments: item);
    } on NoInternetException catch (e) {
      _logger.w('No internet: $e');
      Get.snackbar('No Internet', e.message);
    } on TimeoutException catch (e) {
      _logger.w('Timeout: $e');
      Get.snackbar('Timeout', 'Server took too long. Please try again.');
    } on ServerException catch (e) {
      _logger.e('Server error: $e');
      Get.snackbar('Error', e.message);
    } catch (e) {
      _logger.e('Unknown error: $e');
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    }
  }

  void onDeleteCalculation(int index) {
    final item = filteredCalculations[index];
    Get.dialog(
      DeleteConfirmationDialog(
        onDelete: () async {
          // Close confirmation dialog
          Get.back();

          // Show full-screen loading overlay while API call runs
          Get.dialog(
            const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            barrierColor: Colors.black54,
            barrierDismissible: false,
          );

          try {
            await _deleteCalculationUseCase(item.id);
            calculations.remove(item);
            _logger.i('History: deleted ${item.id}');

            // Close loading overlay, then show success popup
            Get.back();
            Get.dialog(
              const DeleteSuccessDialog(),
              barrierColor: Colors.white24,
            );
          } on NoInternetException catch (e) {
            _logger.w('No internet during delete: $e');
            Get.back(); // close loading overlay
            Get.snackbar('No Internet', e.message);
          } on TimeoutException catch (e) {
            _logger.w('Timeout during delete: $e');
            Get.back(); // close loading overlay
            Get.snackbar('Timeout', 'Server took too long. Please try again.');
          } on ServerException catch (e) {
            _logger.e('Server error during delete: $e');
            Get.back(); // close loading overlay
            Get.snackbar('Error', e.message);
          } catch (e) {
            _logger.e('Unknown error during delete: $e');
            Get.back(); // close loading overlay
            Get.snackbar('Error', 'Something went wrong. Please try again.');
          }
        },
      ),
      barrierColor: Colors.white24,
    );
  }

  void onFilterTap() {
    Get.dialog(
      FilterDialog(
        onConfirm: (objective, date) {
          if (objective == 'Reverse Finance ') {
            selectedFilter.value = 'reverse_refinance';
          } else if (objective == 'Reverse for Purchase') {
            selectedFilter.value = 'reverse_purchase';
          } else {
            selectedFilter.value = null;
          }
          selectedDate.value = date;
        },
      ),
      barrierColor: Colors.white24,
    );
  }

  @override
  void onClose() {
    scrollController.dispose();
    searchController.dispose();
    super.onClose();
  }
}
