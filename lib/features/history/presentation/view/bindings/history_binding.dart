import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/features/history/presentation/view/controller/history_controller.dart';

class HistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryController>(() => HistoryController());
  }
}
