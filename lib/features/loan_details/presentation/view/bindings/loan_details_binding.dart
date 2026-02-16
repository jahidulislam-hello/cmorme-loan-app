import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/features/loan_details/presentation/view/controller/loan_details_controller.dart';

class LoanDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoanDetailsController>(() => LoanDetailsController());
  }
}
