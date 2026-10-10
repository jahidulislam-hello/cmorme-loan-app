import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/core/exceptions/app_exceptions.dart';
import 'package:reverse_mortage_loan_app/features/recent_calculation/data/models/recent_calculation_response_model.dart';
import 'package:reverse_mortage_loan_app/features/recent_calculation/domain/usecases/delete_calculation_usecase.dart';
import 'package:reverse_mortage_loan_app/features/recent_calculation/domain/usecases/get_calculation_by_id_usecase.dart';
import 'package:reverse_mortage_loan_app/features/recent_calculation/domain/usecases/get_recent_calculations_usecase.dart';
import 'package:reverse_mortage_loan_app/shared/dialoges/delete_confirmation_dialog.dart';
import 'package:reverse_mortage_loan_app/shared/dialoges/delete_success_dialog.dart';

class RecentCalculationController extends GetxController {
  final GetRecentCalculationsUseCase _getRecentCalculationsUseCase;
  final DeleteCalculationUseCase _deleteCalculationUseCase;
  final GetCalculationByIdUseCase _getCalculationByIdUseCase;
  final _logger = Logger();

  RecentCalculationController({
    required GetRecentCalculationsUseCase getRecentCalculationsUseCase,
    required DeleteCalculationUseCase deleteCalculationUseCase,
    required GetCalculationByIdUseCase getCalculationByIdUseCase,
  })  : _getRecentCalculationsUseCase = getRecentCalculationsUseCase,
        _deleteCalculationUseCase = deleteCalculationUseCase,
        _getCalculationByIdUseCase = getCalculationByIdUseCase;

  final calculations = <RecentCalculationItemModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCalculations();
  }

  Future<void> fetchCalculations() async {
    isLoading.value = true;
    try {
      final response = await _getRecentCalculationsUseCase(limit: 10);
      calculations.assignAll(response.data);
      _logger.i('Fetched ${calculations.length} calculations');
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
    } finally {
      isLoading.value = false;
    }
  }

  static final _dateFmt = DateFormat('dd MMM yyyy');
  static final _numFmt = NumberFormat('#,##0.##');

  String formatDate(DateTime date) => _dateFmt.format(date);

  String formatAmount(double amount) => _numFmt.format(amount);

  String tagLabel(String financeType) {
    return financeType == 'reverse_purchase'
        ? 'Reverse for Purchase'
        : 'Reverse Refinance';
  }

  Future<void> onViewDetails(int index) async {
    final id = calculations[index].id;
    try {
      final item = await _getCalculationByIdUseCase(id);
      _logger.i('Fetched calculation detail: $id');
      Get.toNamed(RouteNames.loanDetails, arguments: item);
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

  void onDeleteCalculation(int index) {
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

          final id = calculations[index].id;
          try {
            await _deleteCalculationUseCase(id);
            calculations.removeAt(index);
            _logger.i('Deleted calculation: $id');

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
}
