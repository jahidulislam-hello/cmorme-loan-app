import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/core/exceptions/app_exceptions.dart';
import 'package:reverse_mortage_loan_app/features/did_you_know/domain/usecases/get_did_you_know_usecase.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/data/models/calculate_loan_request_model.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/data/models/calculate_loan_response_model.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/domain/usecases/calculate_loan_usecase.dart';

class TipsCalculateController extends GetxController {
  final CalculateLoanUseCase _calculateLoanUseCase;
  final GetDidYouKnowUseCase _getDidYouKnowUseCase;
  final _logger = Logger();

  TipsCalculateController({
    required CalculateLoanUseCase calculateLoanUseCase,
    required GetDidYouKnowUseCase getDidYouKnowUseCase,
  })  : _calculateLoanUseCase = calculateLoanUseCase,
        _getDidYouKnowUseCase = getDidYouKnowUseCase;

  late final String loanType;
  late final CalculateLoanRequestModel _request;

  CalculateLoanResponseModel? _result;
  bool _progressDone = false;
  bool _apiDone = false;
  final isApiError = false.obs;

  static const _defaultTips = [
    'Paying little extra each month can reduce total interest!',
    'Lower monthly payments but increase total cost!',
    'Credit score can affect the loan interest rate you get!',
    'Refinancing later can save money if rates drop!',
    'Comparing multiple lenders helps you find the best deal!',
  ];

  /// Tips shown on screen — set once before animation starts
  final tips = <String>[..._defaultTips].obs;

  /// Becomes true when tips are ready (API responded or 2s timeout hit)
  final tipsReady = false.obs;

  @override
  void onInit() {
    super.onInit();
    try {
      final args = Get.arguments as Map<String, dynamic>;
      loanType = args['type'] as String;
      _request = args['request'] as CalculateLoanRequestModel;
      // Both fired in parallel — neither blocks the other or the UI
      _startApiCall();
      _fetchTips();
    } catch (e) {
      _logger.e('TipsCalculate: invalid arguments — $e');
      isApiError.value = true;
    }
  }

  Future<void> _fetchTips() async {
    try {
      final result = await _getDidYouKnowUseCase()
          .timeout(const Duration(seconds: 2));
      if (result.isNotEmpty) {
        tips.assignAll(result);
        _logger.i('Did you know tips loaded: ${result.length}');
      }
    } catch (e) {
      // Timeout or error — defaults are already set, just proceed
      _logger.w('Tips fetch failed/timed out, using defaults: $e');
    } finally {
      tipsReady.value = true;
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
      Get.offNamed(RouteNames.loanResult, arguments: {
        'type': loanType,
        'result': _result,
      });
    }
  }
}
