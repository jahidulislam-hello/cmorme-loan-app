import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/core/services/api_service.dart';
import 'package:reverse_mortage_loan_app/features/home/presentation/view/controller/home_controller.dart';
import 'package:reverse_mortage_loan_app/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:reverse_mortage_loan_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:reverse_mortage_loan_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:reverse_mortage_loan_app/features/profile/domain/usecases/get_profile_usecase.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileRemoteDatasource>(
      () => ProfileRemoteDatasource(ApiService()),
    );
    Get.lazyPut<ProfileRepository>(
      () => ProfileRepositoryImpl(Get.find<ProfileRemoteDatasource>()),
    );
    Get.lazyPut<GetProfileUseCase>(
      () => GetProfileUseCase(Get.find<ProfileRepository>()),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(getProfileUseCase: Get.find<GetProfileUseCase>()),
    );
  }
}
