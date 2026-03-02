import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class WhyWeEducateScreen extends StatelessWidget {
  const WhyWeEducateScreen({super.key});

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
          'Why We Educate',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _paragraph(
                'We educate for three reasons: ',
                bold: true,
              ),
              const SizedBox(height: 12),
              _paragraph(
                'First, we want our customers to be informed so they can make a wise decision. We are first and foremost educators and we always educate before we solicit. We begin by dispelling the many myths about a Reverse Mortgage. For example, some people believe the bank will own their home and can kick them out. Absolutely Not True! The lender has a lien against your home, much like any other Lender. Another myth: My Heirs will owe the lender. Wrong! Reverse Mortgages are known as non-recourse loans. This means that the lender cannot go after the heirs or any other assets the deceased borrowers may have. Seniors need to learn there\'s a big difference between the old and the New Reverse Mortgage. Today\'s program is highly regulated. With the helpful information, seniors will learn the New Reverse Mortgage is one of safest government insured loan programs.',
              ),
              const SizedBox(height: 16),
              _paragraph(
                'Second, we focus on education because there are several new Reverse-Mortgage Programs that need explaining. For example, Congress just passed the Reverse-Mortgage-For-Purchase Plan allowing seniors to purchase a new home and only use a portion of the current home\'s sale proceeds as a down payment on their new downsized home and the Reverse-Mortgage-for-Purchase Plan will pick up the difference. Plus, the borrower will have no monthly mortgage payments. Another education learning curve is the new 95% Rule. If the home has gone down in value at the time the last remaining borrower passes away, the heirs can pay off the loan balance at 95% of the current market value. If the home is worth more than the loan balance, the heirs can either payoff the loan balance and keep the home and its equity, or sell the home and keep the remaining equity.',
              ),
              const SizedBox(height: 16),
              _paragraph(
                'Finally, we are committed to educating senior homeowners about their Reverse Mortgage responsibilities. They must be able to pay their property taxes, home owner\'s insurance and home owners\' association dues. Otherwise, a Reverse Mortgage is not a financial solvent for them. Our whole purpose of education is to turn mirrors into windows.',
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _paragraph(String text, {bool bold = false}) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors.white,
        fontSize: 13,
        height: 1.6,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
