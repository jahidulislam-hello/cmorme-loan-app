import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/features/authentication/presentation/view/controller/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
