import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/shared/dialoges/delete_confirmation_dialog.dart';
import 'package:reverse_mortage_loan_app/shared/dialoges/delete_success_dialog.dart';

class HomeController extends GetxController {
  final userName = 'Ankon Akash';
  final selectedNavIndex = 0.obs;

  void onNavTap(int index) {
    selectedNavIndex.value = index;
    // if (index == 1) {
    //   Get.toNamed(RouteNames.inbox);
    //   selectedNavIndex.value = 0;
    // } else
    if (index == 1) {
      Get.toNamed(RouteNames.history);
      selectedNavIndex.value = 0;
    } else if (index == 2) {
      Get.toNamed(RouteNames.accountSetting);
      selectedNavIndex.value = 0;
    }
  }

  void onNotification() {
    Get.toNamed(RouteNames.notification);
  }

  void onReverseRefinance() {
    Get.toNamed(RouteNames.reverseRefinance,
        arguments: {'type': 'refinance'});
  }

  void onReverseForPurchase() {
    Get.toNamed(RouteNames.reverseRefinance,
        arguments: {'type': 'purchase'});
  }

  void onReverseMortgageFAQ() {
    Get.toNamed(RouteNames.tipsCalculate);
  }

  void onSeeAllCalculations() {
    Get.toNamed(RouteNames.recentCalculation);
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
}
