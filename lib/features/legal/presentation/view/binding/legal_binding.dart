import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/features/legal/presentation/view/controller/legal_controller.dart';

class LegalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LegalController>(() => LegalController());
  }
}
