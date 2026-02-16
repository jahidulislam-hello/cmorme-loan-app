import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_bottom_nav_bar.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_calculation_item.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_search_bar.dart';
import 'package:reverse_mortage_loan_app/features/history/presentation/view/controller/history_controller.dart';

class HistoryScreen extends GetView<HistoryController> {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: AppColors.white, size: 30),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: const Text(
          'History',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 8),
              CustomSearchBar(
                controller: controller.searchController,
                onFilterTap: controller.onFilterTap,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  children: [
                    CustomCalculationItem(
                      date: '08 Jan 2026',
                      tag: 'Government',
                      homeValue: '\$300,00',
                      loanAmount: '300,00',
                      onViewDetails: controller.onViewDetails,
                      onDelete: controller.onDeleteCalculation,
                    ),
                    const SizedBox(height: 16),
                    CustomCalculationItem(
                      date: '08 Jan 2026',
                      tag: 'Non-Government',
                      homeValue: '\$300,00',
                      loanAmount: '300,00',
                      onViewDetails: controller.onViewDetails,
                      onDelete: controller.onDeleteCalculation,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(() => CustomBottomNavBar(
        selectedIndex: controller.selectedNavIndex.value,
        onTap: controller.onNavTap,
      )),
    );
  }
}
