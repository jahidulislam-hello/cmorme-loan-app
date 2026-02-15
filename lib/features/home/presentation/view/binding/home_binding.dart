import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/features/home/presentation/view/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
