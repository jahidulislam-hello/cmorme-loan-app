import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/core/services/api_service.dart';
import 'package:reverse_mortage_loan_app/features/did_you_know/data/datasources/did_you_know_remote_datasource.dart';
import 'package:reverse_mortage_loan_app/features/did_you_know/data/repositories/did_you_know_repository_impl.dart';
import 'package:reverse_mortage_loan_app/features/did_you_know/domain/repositories/did_you_know_repository.dart';
import 'package:reverse_mortage_loan_app/features/did_you_know/domain/usecases/get_did_you_know_usecase.dart';
import 'package:reverse_mortage_loan_app/features/home/presentation/view/controller/tips_calculate_controller.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/data/datasources/reverse_refinance_remote_datasource.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/data/repositories/reverse_refinance_repository_impl.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/domain/repositories/reverse_refinance_repository.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/domain/usecases/calculate_loan_usecase.dart';

class TipsCalculateBinding extends Bindings {
  @override
  void dependencies() {
    // Calculate Loan chain
    Get.lazyPut<ReverseRefinanceRemoteDatasource>(
      () => ReverseRefinanceRemoteDatasource(ApiService()),
    );
    Get.lazyPut<ReverseRefinanceRepository>(
      () => ReverseRefinanceRepositoryImpl(
        Get.find<ReverseRefinanceRemoteDatasource>(),
      ),
    );
    Get.lazyPut<CalculateLoanUseCase>(
      () => CalculateLoanUseCase(Get.find<ReverseRefinanceRepository>()),
    );

    // Did You Know chain
    Get.lazyPut<DidYouKnowRemoteDatasource>(
      () => DidYouKnowRemoteDatasource(ApiService()),
    );
    Get.lazyPut<DidYouKnowRepository>(
      () => DidYouKnowRepositoryImpl(Get.find<DidYouKnowRemoteDatasource>()),
    );
    Get.lazyPut<GetDidYouKnowUseCase>(
      () => GetDidYouKnowUseCase(Get.find<DidYouKnowRepository>()),
    );

    Get.lazyPut<TipsCalculateController>(
      () => TipsCalculateController(
        calculateLoanUseCase: Get.find<CalculateLoanUseCase>(),
        getDidYouKnowUseCase: Get.find<GetDidYouKnowUseCase>(),
      ),
    );
  }
}
