import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/shared/app_image/app_images.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_button.dart';
import 'package:reverse_mortage_loan_app/features/loan_details/presentation/view/controller/loan_details_controller.dart';
import 'package:reverse_mortage_loan_app/features/loan_details/presentation/view/widgets/loan_image_section.dart';
import 'package:reverse_mortage_loan_app/features/loan_details/presentation/view/widgets/loan_info_section.dart';
import 'package:reverse_mortage_loan_app/features/loan_details/presentation/view/widgets/estimated_mortgage_section.dart';

class _NotEligibleCard extends StatelessWidget {
  final String title;
  final String reason;
  final String? secondReason;

  const _NotEligibleCard({
    required this.title,
    required this.reason,
    this.secondReason,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.containerHighlight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _ReasonRow(reason: reason),
              if (secondReason != null) ...[
                const SizedBox(height: 10),
                _ReasonRow(reason: secondReason!),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ReasonRow extends StatelessWidget {
  final String reason;
  const _ReasonRow({required this.reason});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.info_outline, color: AppColors.accentBlue, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            reason,
            style: const TextStyle(
              color: AppColors.hintGrey,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}

class LoanDetailsScreen extends GetView<LoanDetailsController> {
  const LoanDetailsScreen({super.key});

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
          'Loan Details',
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
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.containerHighlight,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LoanImageSection(
                              imageUrls: controller.imageUrls,
                              currentIndex: controller.currentImageIndex,
                              pageController: controller.pageController,
                            ),
                            const SizedBox(height: 16),
                            LoanInfoSection(
                              date: controller.date,
                              objective: controller.objective,
                              homeValue: controller.homeValue,
                              firstBorrowerAge: controller.firstBorrowerAge,
                              secondBorrowerAge: controller.secondBorrowerAge,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),
                      if (controller.govtLoanAvailable)
                        EstimatedMortgageSection(
                          title: 'Estimated Government Insured Reverse Mortgage',
                          primaryLabel: 'Loan Amount',
                          primaryIconPath: AppImages.loanAmountIcon,
                          primaryAmount: controller.govtLoanAmount,
                          cashAvailable: controller.govtCashAvailable,
                          downPayment: controller.govtDownPayment,
                        )
                      else if (controller.govtNotEligibleReason != null)
                        _NotEligibleCard(
                          title: 'Estimated Government Insured Reverse Mortgage',
                          reason: controller.govtNotEligibleReason!,
                          secondReason: 'Not enough home equity',
                        )
                      else
                        const _NotEligibleCard(
                          title: 'Estimated Government Insured Reverse Mortgage',
                          reason: 'Not enough home equity',
                        ),

                      const SizedBox(height: 24),
                      if (controller.nonGovtLoanAvailable)
                        EstimatedMortgageSection(
                          title: 'Estimated Non-Govt Insured Reverse Mortgage',
                          primaryLabel: 'Loan Amount',
                          primaryIconPath: AppImages.loanAmountIcon,
                          primaryAmount: controller.nonGovtLoanAmount,
                          cashAvailable: controller.nonGovtCashAvailable,
                          downPayment: controller.nonGovtDownPayment,
                        )
                      else if (controller.nonGovtNotEligibleReason != null)
                        _NotEligibleCard(
                          title: 'Estimated Non-Govt Insured Reverse Mortgage',
                          reason: controller.nonGovtNotEligibleReason!,
                          secondReason: 'Not enough home equity',
                        )
                      else
                        const _NotEligibleCard(
                          title: 'Estimated Non-Govt Insured Reverse Mortgage',
                          reason: 'Not enough home equity',
                        ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    CustomButton(
                      text: 'Request Full Proposal',
                      onPressed: controller.onRequestMoreInfo,
                      textColor: AppColors.primary,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Get more information on available line of credit, interest rates, eligibility, and more.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.hintGrey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
