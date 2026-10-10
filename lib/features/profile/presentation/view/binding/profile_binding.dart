import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/core/services/api_service.dart';
import 'package:reverse_mortage_loan_app/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:reverse_mortage_loan_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:reverse_mortage_loan_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:reverse_mortage_loan_app/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:reverse_mortage_loan_app/features/profile/domain/usecases/delete_account_usecase.dart';
import 'package:reverse_mortage_loan_app/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:reverse_mortage_loan_app/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:reverse_mortage_loan_app/features/profile/presentation/view/controller/account_setting_controller.dart';
import 'package:reverse_mortage_loan_app/features/profile/presentation/view/controller/change_password_controller.dart';
import 'package:reverse_mortage_loan_app/features/profile/presentation/view/controller/edit_profile_controller.dart';
import 'package:reverse_mortage_loan_app/features/profile/presentation/view/controller/setting_controller.dart';

class ProfileBinding extends Bindings {
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
    Get.lazyPut<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(Get.find<ProfileRepository>()),
    );
    Get.lazyPut<DeleteAccountUseCase>(
      () => DeleteAccountUseCase(Get.find<ProfileRepository>()),
    );
    Get.lazyPut<AccountSettingController>(
      () => AccountSettingController(
        getProfileUseCase: Get.find<GetProfileUseCase>(),
        deleteAccountUseCase: Get.find<DeleteAccountUseCase>(),
      ),
    );
    Get.lazyPut<EditProfileController>(
      () => EditProfileController(
        getProfileUseCase: Get.find<GetProfileUseCase>(),
        updateProfileUseCase: Get.find<UpdateProfileUseCase>(),
      ),
    );
    Get.lazyPut<ChangePasswordUseCase>(
      () => ChangePasswordUseCase(Get.find<ProfileRepository>()),
    );
    Get.lazyPut<SettingController>(() => SettingController());
    Get.lazyPut<ChangePasswordController>(
      () => ChangePasswordController(
        changePasswordUseCase: Get.find<ChangePasswordUseCase>(),
      ),
    );
  }
}
