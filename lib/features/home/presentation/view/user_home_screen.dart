import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/shared/app_image/app_images.dart';
import 'package:shimmer/shimmer.dart';
import 'package:reverse_mortage_loan_app/features/authentication/presentation/view/controller/auth_controller.dart';
import 'package:reverse_mortage_loan_app/features/inbox/presentation/view/widgets/inbox_item.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_calculate_loan_item.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_calculation_item.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_shimmer_loading_indicator.dart';
import '../../../../shared/widgets/custom_button.dart';
import 'controller/home_controller.dart';

class UserHomeScreen extends GetView<HomeController> {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                      Obx(() {
                        if (controller.isProfileLoading.value) {
                          return Shimmer.fromColors(
                            baseColor: Colors.white12,
                            highlightColor: Colors.white30,
                            child: Container(
                              width: 130,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          );
                        }
                        return Text(
                          controller.userName.value,
                          style: const TextStyle(
                            color: AppColors.blue300,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }),
                    ],
                  ),
                  GestureDetector(
                    onTap: controller.onNotification,
                    child: Container(
                      height: 44,
                      width: 44,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    child: Center(
                      child: SvgPicture.asset(
                        AppImages.notificationHomeIcon,
                        width: 24,
                        height: 24,
                      ),
                    ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              /// Calculate Loan Card
              CustomCalculateLoanItem(
                onReverseRefinance: controller.onReverseRefinance,
                onReverseForPurchase: controller.onReverseForPurchase,
                onReverseMortgageFAQ: controller.onReverseMortgageFAQ,
              ),

              const SizedBox(height: 28),
              CustomButton(
                text: 'Reverse Mortgage FAQ',
                onPressed:(){
                  Get.toNamed(RouteNames.faqQuestions);
                },
                backgroundColor: AppColors.blue600,
                textColor: AppColors.primary,
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

              const SizedBox(height: 10),

              Obx(() {
                if (controller.isCalculationLoading.value) {
                  return const CustomCalculationItemShimmer();
                }

                final item = controller.latestCalculation;
                if (item == null) {
                  return const SizedBox.shrink();
                }

                final date = controller.formatDate(item.createdAt);
                final tag = controller.tagLabel(item.financeType);

                if (AuthController.userRole.value == 'real_estate') {
                  return InboxItem(
                    userName: 'Ankon Akash',
                    email: 'abcd1234@gmail.com',
                    date: date,
                    tag: tag,
                    scenarioText: 'Calculated by 2 scenario',
                    onViewDetails: controller.onViewDetails,
                    onDelete: controller.onDeleteCalculation,
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
                  onViewDetails: controller.onViewDetails,
                  onDelete: controller.onDeleteCalculation,
                );
              }),

              const SizedBox(height: 20),
            ],
          ),
        ),
    );
  }
}
