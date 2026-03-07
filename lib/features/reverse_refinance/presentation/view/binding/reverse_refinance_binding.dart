import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/core/services/api_service.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/data/datasources/reverse_refinance_remote_datasource.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/data/repositories/reverse_refinance_repository_impl.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/domain/repositories/reverse_refinance_repository.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/domain/usecases/calculate_loan_usecase.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/domain/usecases/upload_file_usecase.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/presentation/view/controller/reverse_refinance_controller.dart';

class ReverseRefinanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReverseRefinanceRemoteDatasource>(
      () => ReverseRefinanceRemoteDatasource(ApiService()),
    );
    Get.lazyPut<ReverseRefinanceRepository>(
      () => ReverseRefinanceRepositoryImpl(Get.find<ReverseRefinanceRemoteDatasource>()),
    );
    Get.lazyPut<UploadFileUseCase>(
      () => UploadFileUseCase(Get.find<ReverseRefinanceRepository>()),
    );
    Get.lazyPut<CalculateLoanUseCase>(
      () => CalculateLoanUseCase(Get.find<ReverseRefinanceRepository>()),
    );
    Get.lazyPut<ReverseRefinanceController>(
      () => ReverseRefinanceController(
        uploadFileUseCase: Get.find<UploadFileUseCase>(),
        calculateLoanUseCase: Get.find<CalculateLoanUseCase>(),
      ),
    );
  }
}
