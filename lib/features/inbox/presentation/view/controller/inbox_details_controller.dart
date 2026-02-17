import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/shared/dialoges/delete_confirmation_dialog.dart';
import 'package:reverse_mortage_loan_app/shared/dialoges/delete_success_dialog.dart';

class InboxDetailsController extends GetxController {
  final userName = 'Ankon Akash';
  final userEmail = 'abcd1234@gmai.com';

  void onDeleteInbox() {
    Get.dialog(
      DeleteConfirmationDialog(
        onDelete: () {
          Get.back();
          Get.dialog(
            const DeleteSuccessDialog(),
            barrierColor: Colors.white24,
          );
        },
      ),
      barrierColor: Colors.white24,
    );
  }
}
