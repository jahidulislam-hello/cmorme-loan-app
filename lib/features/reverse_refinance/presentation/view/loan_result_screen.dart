import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/data/models/calculate_loan_response_model.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/shared/widgets/loan_estimate_card.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_button.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/legal_disclaimer.dart';
import 'package:url_launcher/url_launcher.dart';

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

class LoanResultScreen extends StatelessWidget {
  const LoanResultScreen({super.key});

  static final _numFmt = NumberFormat('#,##0.##');

  static Future<void> _callEducator() async {
    final uri = Uri.parse('tel:+18008002190');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  static bool _showNonGovtDisclaimer(CalculateLoanResponseModel? result) {
    if (result?.nonGovtLoanAvailable != true) return false;
    final age1 = result?.multipleBorrowerAge1;
    final age2 = result?.multipleBorrowerAge2;
    return (age1 != null && age1 < 55) || (age2 != null && age2 < 55);
  }

  String _fmt(double? value) {
    if (value == null) return '\$0';
    return '\$${_numFmt.format(value)}';
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
          onPressed: () => Get.offAllNamed(RouteNames.userHome),
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
                      if (result?.govtLoanAvailable == true)
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
                      else if (result?.govtNotEligibleReason != null)
                        _NotEligibleCard(
                          title: 'Estimated Government Insured\nReverse Mortgage',
                          reason: result!.govtNotEligibleReason!,
                          secondReason: 'Not enough home equity',
                        )
                      else
                        const _NotEligibleCard(
                          title: 'Estimated Government Insured\nReverse Mortgage',
                          reason: 'Not enough home equity',
                        ),

                      const SizedBox(height: 20),

                      /// Estimated Non-Government Insured Reverse Mortgage
                      if (result?.nonGovtLoanAvailable == true)
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
                      else if (result?.nonGovtNotEligibleReason != null)
                        _NotEligibleCard(
                          title: 'Estimated Non-Government Insured\nReverse Mortgage',
                          reason: result!.nonGovtNotEligibleReason!,
                          secondReason: 'Not enough home equity',
                        )
                      else
                        const _NotEligibleCard(
                          title: 'Estimated Non-Government Insured\nReverse Mortgage',
                          reason: 'Not enough home equity',
                        ),

                      if (_showNonGovtDisclaimer(result)) ...[
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
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.info_outline,
                                  color: AppColors.accentBlue, size: 16),
                              const SizedBox(width: 8),
                              const Expanded(
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

                      /// Request Full Proposal / Request More Information Button
                      CustomButton(
                        text: (result?.govtLoanAvailable == false &&
                                result?.nonGovtLoanAvailable == false)
                            ? 'Request More Information'
                            : 'Request Full Proposal',
                        onPressed: () {
                          Get.toNamed(RouteNames.requestProposal);
                        },
                        textColor: AppColors.primary,
                        backgroundColor: AppColors.blue100,
                      ),

                      const SizedBox(height: 12),

                      /// Speak to an Educator Button
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: _callEducator,
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

                      const SizedBox(height: 16),
                      const LegalDisclaimer(),
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
