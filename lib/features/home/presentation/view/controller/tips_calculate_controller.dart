import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/core/exceptions/app_exceptions.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/data/models/calculate_loan_request_model.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/data/models/calculate_loan_response_model.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/domain/usecases/calculate_loan_usecase.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class TipsCalculateController extends GetxController {
  final CalculateLoanUseCase _calculateLoanUseCase;
  final _logger = Logger();

  TipsCalculateController({required CalculateLoanUseCase calculateLoanUseCase})
      : _calculateLoanUseCase = calculateLoanUseCase;

  late final String loanType;
  late final CalculateLoanRequestModel _request;

  CalculateLoanResponseModel? _result;
  bool _progressDone = false;
  bool _apiDone = false;
  final isApiError = false.obs;

  @override
  void onInit() {
    super.onInit();
    try {
      final args = Get.arguments as Map<String, dynamic>;
      loanType = args['type'] as String;
      _request = args['request'] as CalculateLoanRequestModel;
      _startApiCall();
    } catch (e) {
      _logger.e('TipsCalculate: invalid arguments — $e');
      isApiError.value = true;
    }
  }

  Future<void> _startApiCall() async {
    try {
      _result = await _calculateLoanUseCase(_request);
      _logger.i('Calculate loan success: ${_result!.id}');
      _apiDone = true;
      _tryNavigate();
    } on NoInternetException catch (e) {
      _logger.w('No internet during calculate loan: $e');
      isApiError.value = true;
      Get.snackbar('No Internet', e.message);
    } on TimeoutException catch (e) {
      _logger.w('Timeout during calculate loan: $e');
      isApiError.value = true;
      Get.snackbar('Timeout', 'Server took too long. Please try again.');
    } on ServerException catch (e) {
      _logger.e('Server error during calculate loan: $e');
      isApiError.value = true;
      Get.snackbar('Error', e.message);
    } catch (e) {
      _logger.e('Unknown error during calculate loan: $e');
      isApiError.value = true;
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    }
  }

  /// Called by [TipsCalculateScreen] when the progress bar animation completes.
  void onProgressCompleted() {
    _progressDone = true;
    _tryNavigate();
  }

  /// Navigates to loanResult only when BOTH the progress bar is done
  /// AND the API call has returned a result.
  void _tryNavigate() {
    if (_progressDone && _apiDone && _result != null) {
      if (!_result!.govtEligible && !_result!.nonGovtEligible) {
        _showNotEligibleDialog();
      } else {
        Get.offNamed(RouteNames.loanResult, arguments: {
          'type': loanType,
          'result': _result,
        });
      }
    }
  }

  void _showNotEligibleDialog() {
    final reasons = <_EligibilityReason>[];
    if (_result!.govtNotEligibleReason != null) {
      reasons.add(_EligibilityReason(
        label: 'Government Insured',
        reason: _result!.govtNotEligibleReason!,
      ));
    }
    if (_result!.nonGovtNotEligibleReason != null) {
      reasons.add(_EligibilityReason(
        label: 'Non-Government Insured',
        reason: _result!.nonGovtNotEligibleReason!,
      ));
    }

    Get.dialog(
      Dialog(
        backgroundColor: AppColors.containerHighlight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.info_outline, color: AppColors.accentBlue, size: 22),
                  SizedBox(width: 8),
                  Text(
                    'Not Eligible',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...reasons.map((r) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          r.label,
                          style: const TextStyle(
                            color: AppColors.accentBlue,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          r.reason,
                          style: const TextStyle(
                            color: AppColors.hintGrey,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Get.back(); // close dialog
                    Get.back(); // back to refinance screen
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.buttonBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}

class _EligibilityReason {
  final String label;
  final String reason;
  const _EligibilityReason({required this.label, required this.reason});
}
