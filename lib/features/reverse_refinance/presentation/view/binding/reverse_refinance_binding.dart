import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/presentation/view/controller/reverse_refinance_controller.dart';

class ReverseRefinanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReverseRefinanceController>(() => ReverseRefinanceController());
  }
}
