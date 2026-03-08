import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/core/exceptions/app_exceptions.dart';
import 'package:reverse_mortage_loan_app/core/services/cache_service.dart';
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
  final selectedNavIndex = 1.obs;

  final calculations = <RecentCalculationItemModel>[].obs;
  final isLoading = false.obs;

  // null = no filter, 'reverse_refinance' or 'peverse_purchase'
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
    fetchCalculations();
  }

  static const _cacheKey = 'recent_calculations';

  Future<void> fetchCalculations() async {
    isLoading.value = true;
    try {
      final response = await _getRecentCalculationsUseCase(limit: 10);
      calculations.assignAll(response.data);
      await CacheService().put(
        _cacheKey,
        response.data.map((e) => e.toJson()).toList(),
      );
      _logger.i('History: fetched ${calculations.length} calculations');
    } on NoInternetException catch (e) {
      _logger.w('History: no internet — loading from cache: $e');
      _loadFromCache();
    //  Get.snackbar('No Internet', 'Showing cached data.');
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

  void _loadFromCache() {
    try {
      final cached = CacheService().get<List>(_cacheKey);
      if (cached != null && cached.isNotEmpty) {
        final items = cached
            .map((e) => RecentCalculationItemModel.fromJson(
                Map<String, dynamic>.from(e as Map)))
            .toList();
        calculations.assignAll(items);
        _logger.i('History: loaded ${items.length} calculations from cache');
      }
    } catch (e) {
      _logger.e('History: failed to load from cache: $e');
    }
  }

  String formatDate(DateTime date) => DateFormat('dd MMM yyyy').format(date);

  String formatAmount(double amount) => NumberFormat('#,##0.##').format(amount);

  String tagLabel(String financeType) =>
      financeType == 'peverse_purchase' ? 'Reverse for Purchase' : 'Reverse Refinance';

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
          Get.back();
          try {
            await _deleteCalculationUseCase(item.id);
            calculations.remove(item);
            _logger.i('History: deleted ${item.id}');
            Get.dialog(
              const DeleteSuccessDialog(),
              barrierColor: Colors.white24,
            );
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

  void onFilterTap() {
    Get.dialog(
      FilterDialog(
        onConfirm: (objective, date) {
          if (objective == 'Reverse Finance ') {
            selectedFilter.value = 'reverse_refinance';
          } else if (objective == 'Reverse for Purchase') {
            selectedFilter.value = 'peverse_purchase';
          } else {
            selectedFilter.value = null;
          }
          selectedDate.value = date;
        },
      ),
      barrierColor: Colors.white24,
    );
  }

  void onNavTap(int index) {
    if (index == 1) return;
    if (index == 0) {
      Get.back();
    } else if (index == 2) {
      Get.offNamed(RouteNames.accountSetting);
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
