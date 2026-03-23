import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/core/services/api_service.dart';
import 'package:reverse_mortage_loan_app/features/faq/data/datasources/faq_remote_datasource.dart';
import 'package:reverse_mortage_loan_app/features/faq/data/repositories/faq_repository_impl.dart';
import 'package:reverse_mortage_loan_app/features/faq/domain/repositories/faq_repository.dart';
import 'package:reverse_mortage_loan_app/features/faq/domain/usecases/get_faqs_usecase.dart';
import 'package:reverse_mortage_loan_app/features/faq/presentation/view/controller/faq_controller.dart';
import 'package:reverse_mortage_loan_app/features/faq/presentation/view/controller/faq_questions_controller.dart';
import 'package:reverse_mortage_loan_app/features/faq/presentation/view/controller/instant_quote_controller.dart';

class FaqBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaqRemoteDatasource>(
      () => FaqRemoteDatasource(ApiService()),
    );
    Get.lazyPut<FaqRepository>(
      () => FaqRepositoryImpl(Get.find<FaqRemoteDatasource>()),
    );
    Get.lazyPut<GetFaqsUseCase>(
      () => GetFaqsUseCase(Get.find<FaqRepository>()),
    );
    Get.lazyPut<FaqController>(() => FaqController());
    Get.lazyPut<FaqQuestionsController>(
      () => FaqQuestionsController(getFaqsUseCase: Get.find<GetFaqsUseCase>()),
    );
    Get.lazyPut<InstantQuoteController>(() => InstantQuoteController());
  }
}
