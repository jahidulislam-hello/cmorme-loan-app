import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/features/authentication/presentation/view/controller/auth_controller.dart';
import 'package:reverse_mortage_loan_app/features/inbox/presentation/view/widgets/inbox_item.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_calculation_item.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_shimmer_loading_indicator.dart';
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
        child: Obx(() {
          if (controller.isLoading.value) {
            return const CustomShimmerLoadingIndicator(itemCount: 3);
          }

          if (controller.calculations.isEmpty) {
            return RefreshIndicator(
              onRefresh: controller.fetchCalculations,
              color: AppColors.primary,
              backgroundColor: AppColors.white,
              child: const SingleChildScrollView(
                physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                child: SizedBox(
                  height: 400,
                  child: Center(
                    child: Text(
                      'No calculations yet.',
                      style: TextStyle(color: AppColors.hintGrey, fontSize: 16),
                    ),
                  ),
                ),
              ),
            );
          }

          final isRealEstate = AuthController.userRole.value == 'real_estate';

          return RefreshIndicator(
            onRefresh: controller.fetchCalculations,
            color: AppColors.primary,
            backgroundColor: AppColors.white,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              itemCount: controller.calculations.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final item = controller.calculations[index];
                final date = controller.formatDate(item.createdAt);
                final tag = controller.tagLabel(item.financeType);

                if (isRealEstate) {
                  return InboxItem(
                    userName: 'Ankon Akash',
                    email: 'abcd1234@gmail.com',
                    date: date,
                    tag: tag,
                    scenarioText: 'Calculated by 2 scenario',
                    onViewDetails: () => controller.onViewDetails(index),
                    onDelete: () => controller.onDeleteCalculation(index),
                  );
                }

                return CustomCalculationItem(
                  date: date,
                  tag: tag,
                  loanAmount: controller.formatAmount(item.govtLoanAmount),
                  cashAvailable: controller.formatAmount(item.govtCashOrDownPayment),
                  downPayment: item.isPurchase
                      ? controller.formatAmount(item.govtCashOrDownPayment)
                      : null,
                  onViewDetails: () => controller.onViewDetails(index),
                  onDelete: () => controller.onDeleteCalculation(index),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
