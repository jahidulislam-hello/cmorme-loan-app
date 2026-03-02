import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/features/faq/presentation/view/controller/faq_controller.dart';
import 'package:reverse_mortage_loan_app/features/faq/presentation/view/controller/faq_questions_controller.dart';
import 'package:reverse_mortage_loan_app/features/faq/presentation/view/controller/instant_quote_controller.dart';

class FaqBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaqController>(() => FaqController());
    Get.lazyPut<FaqQuestionsController>(() => FaqQuestionsController());
    Get.lazyPut<InstantQuoteController>(() => InstantQuoteController());
  }
}
