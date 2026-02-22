import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/shared/widgets/loan_estimate_card.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_button.dart';

class LoanResultScreen extends StatelessWidget {
  const LoanResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;
    final type = args?['type'] ?? 'refinance';
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
                      LoanEstimateCard(
                        title: 'Estimated Government Insured\nReverse Mortgage',
                        loanAmount: '\$1500',
                        cashAvailable: '\$1500',
                        downPayment: isPurchase ? '\$1500' : null,
                      ),

                      const SizedBox(height: 20),

                      /// Estimated Non-Government Insured Reverse Mortgage
                      LoanEstimateCard(
                        title:
                            'Estimated Non-Government Insured\nReverse Mortgage',
                        loanAmount: '\$1500',
                        cashAvailable: '\$1500',
                        downPayment: isPurchase ? '\$1500' : null,
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
                          "Users to hit 'request full proposal' and send more information",
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
