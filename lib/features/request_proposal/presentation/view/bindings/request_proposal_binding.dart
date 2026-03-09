import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/core/services/api_service.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/data/datasources/request_proposal_remote_datasource.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/data/repositories/request_proposal_repository_impl.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/domain/repositories/request_proposal_repository.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/domain/usecases/create_proposal_usecase.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/domain/usecases/get_my_proposal_usecase.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/domain/usecases/update_proposal_usecase.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/presentation/view/controller/request_proposal_controller.dart';

class RequestProposalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestProposalRemoteDatasource>(
      () => RequestProposalRemoteDatasource(ApiService()),
    );
    Get.lazyPut<RequestProposalRepository>(
      () => RequestProposalRepositoryImpl(
        Get.find<RequestProposalRemoteDatasource>(),
      ),
    );
    Get.lazyPut<GetMyProposalUseCase>(
      () => GetMyProposalUseCase(Get.find<RequestProposalRepository>()),
    );
    Get.lazyPut<CreateProposalUseCase>(
      () => CreateProposalUseCase(Get.find<RequestProposalRepository>()),
    );
    Get.lazyPut<UpdateProposalUseCase>(
      () => UpdateProposalUseCase(Get.find<RequestProposalRepository>()),
    );
    Get.lazyPut<RequestProposalController>(
      () => RequestProposalController(
        getMyProposalUseCase: Get.find<GetMyProposalUseCase>(),
        createProposalUseCase: Get.find<CreateProposalUseCase>(),
        updateProposalUseCase: Get.find<UpdateProposalUseCase>(),
      ),
    );
  }
}
