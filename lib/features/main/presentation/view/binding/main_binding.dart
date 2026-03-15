import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/core/services/api_service.dart';
import 'package:reverse_mortage_loan_app/features/home/presentation/view/controller/home_controller.dart';
import 'package:reverse_mortage_loan_app/features/history/presentation/view/controller/history_controller.dart';
import 'package:reverse_mortage_loan_app/features/main/presentation/view/controller/main_controller.dart';
import 'package:reverse_mortage_loan_app/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:reverse_mortage_loan_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:reverse_mortage_loan_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:reverse_mortage_loan_app/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:reverse_mortage_loan_app/features/profile/presentation/view/controller/account_setting_controller.dart';
import 'package:reverse_mortage_loan_app/features/recent_calculation/data/datasources/recent_calculation_remote_datasource.dart';
import 'package:reverse_mortage_loan_app/features/recent_calculation/data/repositories/recent_calculation_repository_impl.dart';
import 'package:reverse_mortage_loan_app/features/recent_calculation/domain/repositories/recent_calculation_repository.dart';
import 'package:reverse_mortage_loan_app/features/recent_calculation/domain/usecases/delete_calculation_usecase.dart';
import 'package:reverse_mortage_loan_app/features/recent_calculation/domain/usecases/get_calculation_by_id_usecase.dart';
import 'package:reverse_mortage_loan_app/features/recent_calculation/domain/usecases/get_recent_calculations_usecase.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    // Shared: RecentCalculation
    Get.lazyPut<RecentCalculationRemoteDatasource>(
      () => RecentCalculationRemoteDatasource(ApiService()),
    );
    Get.lazyPut<RecentCalculationRepository>(
      () => RecentCalculationRepositoryImpl(
        Get.find<RecentCalculationRemoteDatasource>(),
      ),
    );
    Get.lazyPut<GetRecentCalculationsUseCase>(
      () => GetRecentCalculationsUseCase(Get.find<RecentCalculationRepository>()),
    );
    Get.lazyPut<DeleteCalculationUseCase>(
      () => DeleteCalculationUseCase(Get.find<RecentCalculationRepository>()),
    );
    Get.lazyPut<GetCalculationByIdUseCase>(
      () => GetCalculationByIdUseCase(Get.find<RecentCalculationRepository>()),
    );

    // Shared: Profile
    Get.lazyPut<ProfileRemoteDatasource>(
      () => ProfileRemoteDatasource(ApiService()),
    );
    Get.lazyPut<ProfileRepository>(
      () => ProfileRepositoryImpl(Get.find<ProfileRemoteDatasource>()),
    );
    Get.lazyPut<GetProfileUseCase>(
      () => GetProfileUseCase(Get.find<ProfileRepository>()),
    );

    // Tab controllers
    Get.lazyPut<HomeController>(
      () => HomeController(
        getProfileUseCase: Get.find<GetProfileUseCase>(),
        getRecentCalculationsUseCase: Get.find<GetRecentCalculationsUseCase>(),
        deleteCalculationUseCase: Get.find<DeleteCalculationUseCase>(),
        getCalculationByIdUseCase: Get.find<GetCalculationByIdUseCase>(),
      ),
    );
    Get.lazyPut<HistoryController>(
      () => HistoryController(
        getRecentCalculationsUseCase: Get.find<GetRecentCalculationsUseCase>(),
        deleteCalculationUseCase: Get.find<DeleteCalculationUseCase>(),
        getCalculationByIdUseCase: Get.find<GetCalculationByIdUseCase>(),
      ),
    );
    Get.lazyPut<AccountSettingController>(() => AccountSettingController());

    // Shell controller
    Get.lazyPut<MainController>(() => MainController());
  }
}
