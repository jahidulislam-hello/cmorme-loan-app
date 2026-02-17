import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/features/authentication/presentation/view/controller/auth_controller.dart';
import 'package:reverse_mortage_loan_app/features/inbox/presentation/view/widgets/inbox_item.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_bottom_nav_bar.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_calculate_loan_item.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_calculation_item.dart';
import 'controller/home_controller.dart';

class UserHomeScreen extends GetView<HomeController> {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              /// Greeting & Notification Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Good Morning,',
                        style: TextStyle(
                          color: AppColors.hintGrey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        controller.userName,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: controller.onNotification,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.notifications_none,
                        color: AppColors.primary,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              /// Calculate Loan Card
              CustomCalculateLoanItem(
                onStartPressed: controller.onStartCalculation,
              ),

              const SizedBox(height: 28),

              /// Recent Calculation Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Calculation',
                    style: TextStyle(
                      color: AppColors.blue300,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.onSeeAllCalculations,
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              Obx(() => AuthController.userRole.value == 'real_estate'
                  ? InboxItem(
                      userName: 'Ankon Akash',
                      email: 'abcd1234@gmai.com',
                      date: '08 Jan 2026',
                      tag: 'Refinance',
                      scenarioText: 'Calculated by 2 scenario',
                      onViewDetails: controller.onViewDetails,
                      onDelete: controller.onDeleteCalculation,
                    )
                  : CustomCalculationItem(
                      date: '08 Jan 2026',
                      tag: 'Government',
                      homeValue: '\$300,00',
                      loanAmount: '300,00',
                      onViewDetails: controller.onViewDetails,
                      onDelete: controller.onDeleteCalculation,
                    ),
              ),

              const SizedBox(height: 20),
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
