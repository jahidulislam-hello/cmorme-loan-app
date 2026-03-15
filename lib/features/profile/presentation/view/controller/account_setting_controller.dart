import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/core/services/token_service.dart';
import 'package:reverse_mortage_loan_app/shared/dialoges/logout_dialog.dart';

class AccountSettingController extends GetxController {
  void onEditProfile() {
    Get.toNamed(RouteNames.editProfile);
  }

  void onSetting() {
    Get.toNamed(RouteNames.setting);
  }

  void onLogout() {
    Get.dialog(
      LogoutDialog(
        onLogout: () async {
          await TokenService().deleteToken();
          Get.back();
          Get.offAllNamed(RouteNames.signIn);
        },
      ),
      barrierColor: Colors.white24,
    );
  }
}
