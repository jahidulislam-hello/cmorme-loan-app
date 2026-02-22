import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/shared/dialoges/logout_dialog.dart';

class AccountSettingController extends GetxController {
  final selectedNavIndex = 2.obs;

  void onNavTap(int index) {
    if (index == 2) return;
    if (index == 0) {
      Get.back();
    // } else if (index == 1) {
    //   Get.offNamed(RouteNames.inbox);
    } else if (index == 1) {
      Get.offNamed(RouteNames.history);
    }
  }

  void onEditProfile() {
    Get.toNamed(RouteNames.editProfile);
  }

  void onSetting() {
    Get.toNamed(RouteNames.setting);
  }

  void onLogout() {
    Get.dialog(
      LogoutDialog(
        onLogout: () {
          Get.back();
          Get.offAllNamed(RouteNames.signIn);
        },
      ),
      barrierColor: Colors.white24,
    );
  }
}
