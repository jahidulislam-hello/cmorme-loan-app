import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:reverse_mortage_loan_app/core/constants/api_constants.dart';
import 'package:reverse_mortage_loan_app/core/exceptions/app_exceptions.dart';
import 'package:reverse_mortage_loan_app/features/legal/domain/usecases/get_legal_content_usecase.dart';

class LegalController extends GetxController {
  final GetLegalContentUseCase _getLegalContentUseCase;
  final _logger = Logger();

  LegalController({required GetLegalContentUseCase getLegalContentUseCase})
      : _getLegalContentUseCase = getLegalContentUseCase;

  final isLoading = true.obs;
  final htmlContent = ''.obs;

  late final String title;

  @override
  void onInit() {
    super.onInit();
    title = Get.arguments as String? ?? 'Legal';
    _fetchContent();
  }

  String get _endpoint {
    switch (title) {
      case 'Privacy Policy':
        return ApiConstants.legalPrivacy;
      case 'About Us':
        return ApiConstants.legalAbout;
      default: // 'Terms & Condition'
        return ApiConstants.legalTerms;
    }
  }

  Future<void> _fetchContent() async {
    try {
      isLoading.value = true;
      final result = await _getLegalContentUseCase(_endpoint);
      htmlContent.value = result.description;
    } on NoInternetException catch (e) {
      Get.snackbar('No Internet', e.message);
    } on TimeoutException catch (e) {
      Get.snackbar('Timeout', e.message);
    } on ServerException catch (e) {
      Get.snackbar('Error', e.message);
    } catch (e) {
      _logger.e('getLegalContent error: $e');
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }
}
