import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/shared/app_image/app_images.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_button.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/legal_disclaimer.dart';
import 'package:url_launcher/url_launcher.dart';
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
                      if (controller.govtLoanAvailable || controller.rawGovtCashAvailable < 0)
                        EstimatedMortgageSection(
                          title: 'Estimated Government Insured Reverse Mortgage',
                          primaryLabel: 'Loan Amount',
                          primaryIconPath: AppImages.loanAmountIcon,
                          primaryAmount: controller.govtLoanAmount,
                          cashAvailable: controller.govtCashAvailable,
                          cashAvailableLabel: controller.govtCashAvailableLabel,
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
                      if (controller.nonGovtLoanAvailable || controller.rawNonGovtCashAvailable < 0)
                        EstimatedMortgageSection(
                          title: 'Estimated Non-Govt Insured Reverse Mortgage',
                          primaryLabel: 'Loan Amount',
                          primaryIconPath: AppImages.loanAmountIcon,
                          primaryAmount: controller.nonGovtLoanAmount,
                          cashAvailable: controller.nonGovtCashAvailable,
                          cashAvailableLabel: controller.nonGovtCashAvailableLabel,
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

                      if (controller.showNonGovtAgeDisclaimer) ...[
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.containerHighlight,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: AppColors.accentBlue.withOpacity(0.4)),
                          ),
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.info_outline,
                                  color: AppColors.accentBlue, size: 16),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'For the Non-Government Reverse Mortgage, the youngest borrower is not included in the loan.',
                                  style: TextStyle(
                                    color: AppColors.hintGrey,
                                    fontSize: 12,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      const SizedBox(height: 16),
                      const LegalDisclaimer(),
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
                    const SizedBox(height: 12),
                    SizedBox(
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
