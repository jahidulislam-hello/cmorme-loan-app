import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/core/exceptions/app_exceptions.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/data/models/calculate_loan_request_model.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/data/models/calculate_loan_response_model.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/domain/usecases/calculate_loan_usecase.dart';

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

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    loanType = args['type'] as String;
    _request = args['request'] as CalculateLoanRequestModel;
    _startApiCall();
  }

  Future<void> _startApiCall() async {
    try {
      _result = await _calculateLoanUseCase(_request);
      _logger.i('Calculate loan success: ${_result!.id}');
      _apiDone = true;
      _tryNavigate();
    } on NoInternetException catch (e) {
      _logger.w('No internet during calculate loan: $e');
      Get.snackbar('No Internet', e.message);
    } on TimeoutException catch (e) {
      _logger.w('Timeout during calculate loan: $e');
      Get.snackbar('Timeout', 'Server took too long. Please try again.');
    } on ServerException catch (e) {
      _logger.e('Server error during calculate loan: $e');
      Get.snackbar('Error', e.message);
    } catch (e) {
      _logger.e('Unknown error during calculate loan: $e');
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
      Get.offNamed(RouteNames.loanResult, arguments: {
        'type': loanType,
        'result': _result,
      });
    }
  }
}
