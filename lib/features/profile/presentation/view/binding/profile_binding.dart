import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/features/profile/presentation/view/controller/account_setting_controller.dart';
import 'package:reverse_mortage_loan_app/features/profile/presentation/view/controller/edit_profile_controller.dart';
import 'package:reverse_mortage_loan_app/features/profile/presentation/view/controller/setting_controller.dart';
import 'package:reverse_mortage_loan_app/features/profile/presentation/view/controller/change_password_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountSettingController>(() => AccountSettingController());
    Get.lazyPut<EditProfileController>(() => EditProfileController());
    Get.lazyPut<SettingController>(() => SettingController());
    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController());
  }
}
