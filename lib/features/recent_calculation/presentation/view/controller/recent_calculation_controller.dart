import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/shared/dialoges/delete_confirmation_dialog.dart';
import 'package:reverse_mortage_loan_app/shared/dialoges/delete_success_dialog.dart';

class RecentCalculationController extends GetxController {
  final calculations = <Map<String, String>>[
    {
      'date': '08 Jan 2026',
      'tag': 'Government',
      'cashAvailable': '300,00',
      'loanAmount': '300,00',
    },
    {
      'date': '08 Jan 2026',
      'tag': 'Non-Government',
      'cashAvailable': '300,00',
      'loanAmount': '300,00',
    },
    {
      'date': '08 Jan 2026',
      'tag': 'Government',
      'cashAvailable': '300,00',
      'loanAmount': '300,00',
    },
  ].obs;

  void onViewDetails(int index) {
    // TODO: Navigate to calculation details
  }

  void onDeleteCalculation(int index) {
    Get.dialog(
      DeleteConfirmationDialog(
        onDelete: () {
          Get.back();
          calculations.removeAt(index);
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
