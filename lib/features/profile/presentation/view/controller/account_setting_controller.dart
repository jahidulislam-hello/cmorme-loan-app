import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';

class AccountSettingController extends GetxController {
  final selectedNavIndex = 3.obs;

  void onNavTap(int index) {
    if (index == 3) return;
    if (index == 0) {
      Get.back();
    } else if (index == 1) {
      Get.offNamed(RouteNames.inbox);
    } else if (index == 2) {
      Get.offNamed(RouteNames.history);
    }
  }

  void onEditProfile() {
    Get.toNamed(RouteNames.editProfile);
  }

  void onSetting() {
    Get.toNamed(RouteNames.setting);
  }
}
