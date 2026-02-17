import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';

class SettingController extends GetxController {
  void onChangePassword() {
    Get.toNamed(RouteNames.changePassword);
  }

  void onTermsAndCondition() {
    Get.toNamed(RouteNames.legal, arguments: 'Terms & Condition');
  }

  void onPrivacyPolicy() {
    Get.toNamed(RouteNames.legal, arguments: 'Privacy Policy');
  }

  void onAboutUs() {
    Get.toNamed(RouteNames.legal, arguments: 'About Us');
  }
}
