import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_calculation_item.dart';
import 'controller/recent_calculation_controller.dart';

class RecentCalculationScreen extends GetView<RecentCalculationController> {
  const RecentCalculationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.white),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: const Text(
          'Recent Calculation',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(() => ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              itemCount: controller.calculations.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final item = controller.calculations[index];
                return CustomCalculationItem(
                  date: item['date']!,
                  tag: item['tag']!,
                  homeValue: item['homeValue']!,
                  loanAmount: item['loanAmount']!,
                  onViewDetails: () => controller.onViewDetails(index),
                  onDelete: () => controller.onDeleteCalculation(index),
                );
              },
            )),
      ),
    );
  }
}
