import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/presentation/view/controller/request_proposal_controller.dart';

class RequestProposalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestProposalController>(() => RequestProposalController());
  }
}
