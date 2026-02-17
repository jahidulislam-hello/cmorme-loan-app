import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/features/inbox/presentation/view/controller/inbox_controller.dart';
import 'package:reverse_mortage_loan_app/features/inbox/presentation/view/controller/inbox_details_controller.dart';

class InboxBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InboxController>(() => InboxController());
    Get.lazyPut<InboxDetailsController>(() => InboxDetailsController());
  }
}
