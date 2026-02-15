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
  }

  void onStartCalculation() {
    Get.toNamed(RouteNames.calculateOptions);
  }

  void onSeeAllCalculations() {
    Get.toNamed(RouteNames.recentCalculation);
  }

  void onViewDetails() {
    // TODO: Navigate to calculation details
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
