import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/features/notification/presentation/view/controller/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(() => NotificationController());
  }
}
