import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/shared/dialoges/delete_confirmation_dialog.dart';
import 'package:reverse_mortage_loan_app/shared/dialoges/delete_success_dialog.dart';
import 'package:reverse_mortage_loan_app/shared/dialoges/filter_dialog.dart';

class HistoryController extends GetxController {
  final searchController = TextEditingController();
  final selectedNavIndex = 1.obs;

  void onNavTap(int index) {
    if (index == 1) return;
    if (index == 0) {
      Get.back();
    // } else if (index == 1) {
    //   Get.offNamed(RouteNames.inbox);
    } else if (index == 2) {
      Get.offNamed(RouteNames.accountSetting);
    }
  }

  void onViewDetails() {
    Get.toNamed(RouteNames.loanDetails);
  }

  void onDeleteCalculation() {
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

  void onFilterTap() {
    Get.dialog(
      FilterDialog(),
      barrierColor: Colors.white24,
    );
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
