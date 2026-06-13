import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/features/authentication/presentation/view/controller/auth_controller.dart';
import 'package:reverse_mortage_loan_app/features/inbox/presentation/view/widgets/inbox_item.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_calculation_item.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_shimmer_loading_indicator.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/legal_disclaimer.dart';
import 'package:url_launcher/url_launcher.dart';
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
        child: Column(
          children: [
            Expanded(child: Obx(() {
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
                  loanAmount: controller.formatAmount(item.displayLoanAmount),
                  cashAvailable: controller.formatAmount(item.displayCashOrDownPayment),
                  downPayment: item.isPurchase
                      ? controller.formatAmount(item.displayCashOrDownPayment)
                      : null,
                  onViewDetails: () => controller.onViewDetails(index),
                  onDelete: () => controller.onDeleteCalculation(index),
                );
              },
            ),
          );
        })),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final uri = Uri.parse('tel:+18008002190');
                    if (await canLaunchUrl(uri)) await launchUrl(uri);
                  },
                  icon: const Icon(Icons.phone, size: 18),
                  label: const Text('Speak to an Educator'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.white,
                    side: const BorderSide(color: AppColors.white, width: 1.5),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: LegalDisclaimer(),
            ),
          ],
        ),
      ),
    );
  }
}
