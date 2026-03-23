import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:reverse_mortage_loan_app/core/exceptions/app_exceptions.dart';
import 'package:reverse_mortage_loan_app/features/faq/data/models/faq_response_model.dart';
import 'package:reverse_mortage_loan_app/features/faq/domain/usecases/get_faqs_usecase.dart';

class FaqQuestionsController extends GetxController {
  final GetFaqsUseCase _getFaqsUseCase;
  final _logger = Logger();

  FaqQuestionsController({required GetFaqsUseCase getFaqsUseCase})
      : _getFaqsUseCase = getFaqsUseCase;

  final faqItems = <FaqItemModel>[].obs;
  final isLoading = true.obs;
  final expandedIndex = RxnInt();

  @override
  void onInit() {
    super.onInit();
    _loadFaqs();
  }

  Future<void> _loadFaqs() async {
    try {
      isLoading.value = true;
      final items = await _getFaqsUseCase();
      faqItems.assignAll(items);
      _logger.i('FAQs loaded: ${items.length} items');
    } on NoInternetException catch (e) {
      _logger.w('No internet: $e');
      Get.snackbar('No Internet', e.message);
    } on ServerException catch (e) {
      _logger.e('Server error: $e');
      Get.snackbar('Error', e.message);
    } catch (e) {
      _logger.e('Unknown error loading FAQs: $e');
      Get.snackbar('Error', 'Failed to load FAQs. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  void toggleExpanded(int index) {
    expandedIndex.value = expandedIndex.value == index ? null : index;
  }
}
