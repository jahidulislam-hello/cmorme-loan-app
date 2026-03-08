import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/core/services/api_service.dart';
import 'package:reverse_mortage_loan_app/features/legal/data/datasources/legal_remote_datasource.dart';
import 'package:reverse_mortage_loan_app/features/legal/data/repositories/legal_repository_impl.dart';
import 'package:reverse_mortage_loan_app/features/legal/domain/repositories/legal_repository.dart';
import 'package:reverse_mortage_loan_app/features/legal/domain/usecases/get_legal_content_usecase.dart';
import 'package:reverse_mortage_loan_app/features/legal/presentation/view/controller/legal_controller.dart';

class LegalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LegalRemoteDatasource>(
      () => LegalRemoteDatasource(ApiService()),
    );
    Get.lazyPut<LegalRepository>(
      () => LegalRepositoryImpl(Get.find<LegalRemoteDatasource>()),
    );
    Get.lazyPut<GetLegalContentUseCase>(
      () => GetLegalContentUseCase(Get.find<LegalRepository>()),
    );
    Get.lazyPut<LegalController>(
      () => LegalController(
        getLegalContentUseCase: Get.find<GetLegalContentUseCase>(),
      ),
    );
  }
}
