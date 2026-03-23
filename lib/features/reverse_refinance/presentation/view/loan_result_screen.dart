import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/data/models/calculate_loan_response_model.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/shared/widgets/loan_estimate_card.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_button.dart';

class _NotEligibleCard extends StatelessWidget {
  final String title;
  final String reason;

  const _NotEligibleCard({required this.title, required this.reason});

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
          child: Row(
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
          ),
        ),
      ],
    );
  }
}

class LoanResultScreen extends StatelessWidget {
  const LoanResultScreen({super.key});

  String _fmt(double? value) {
    if (value == null) return '\$0';
    return '\$${value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2)}';
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;
    final type = args?['type'] ?? 'refinance';
    final result = args?['result'] as CalculateLoanResponseModel?;
    final isPurchase = type == 'purchase';
    final title = isPurchase ? 'Reverse for Purchase' : 'Reverse Refinance';

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
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),

                      /// Estimated Government Insured Reverse Mortgage
                      if (result?.govtEligible == true)
                        LoanEstimateCard(
                          title: 'Estimated Government Insured\nReverse Mortgage',
                          loanAmount: isPurchase
                              ? _fmt(result?.reversePurchaseGovtLoanAmount)
                              : _fmt(result?.reverseRefinanceGovtLoanAmount),
                          cashAvailable: isPurchase
                              ? null
                              : _fmt(result?.reverseRefinanceGovtCashAvailable),
                          downPayment: isPurchase
                              ? _fmt(result?.reversePurchaseGovtDownPayment)
                              : null,
                        )
                      else
                        _NotEligibleCard(
                          title: 'Estimated Government Insured\nReverse Mortgage',
                          reason: result?.govtNotEligibleReason ?? 'Not eligible for government reverse mortgage.',
                        ),

                      const SizedBox(height: 20),

                      /// Estimated Non-Government Insured Reverse Mortgage
                      if (result?.nonGovtEligible == true)
                        LoanEstimateCard(
                          title: 'Estimated Non-Government Insured\nReverse Mortgage',
                          loanAmount: isPurchase
                              ? _fmt(result?.reversePurchaseNonGovtLoanAmount)
                              : _fmt(result?.reverseRefinanceNonGovtLoanAmount),
                          cashAvailable: isPurchase
                              ? null
                              : _fmt(result?.reverseRefinanceNonGovtCashAvailable),
                          downPayment: isPurchase
                              ? _fmt(result?.reversePurchaseNonGovtDownPayment)
                              : null,
                        )
                      else
                        _NotEligibleCard(
                          title: 'Estimated Non-Government Insured\nReverse Mortgage',
                          reason: result?.nonGovtNotEligibleReason ?? 'Not eligible for non-government reverse mortgage.',
                        ),

                      const Spacer(),

                      /// Start New Calculation Button
                      CustomButton(
                        text: 'Start New Calculation',
                        onPressed: () {
                          Get.offAllNamed(RouteNames.userHome);
                        },
                        backgroundColor: AppColors.blue600,
                        textColor: AppColors.white,
                      ),
                      const SizedBox(height: 12),

                      /// Request Full Proposal Button
                      CustomButton(
                        text: 'Request Full Proposal',
                        onPressed: () {
                          Get.toNamed(RouteNames.requestProposal);
                        },
                        textColor: AppColors.primary,
                        backgroundColor: AppColors.blue100,
                      ),

                      const SizedBox(height: 8),

                      const Center(
                        child: Text(
                          'Get more information on available line of credit, interest rates, eligibility, and more.',

                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.hintGrey,
                            fontSize: 11,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
