import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/features/recent_calculation/presentation/view/controller/recent_calculation_controller.dart';

class RecentCalculationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecentCalculationController>(
        () => RecentCalculationController());
  }
}
