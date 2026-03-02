import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/shared/app_image/app_images.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

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
          'About Us',
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
              _bodyText(
                'The New Reverse Mortgage allows homeowners over the age of 62 to safely tap into their home equity and not pay it back until the home is sold. The equity monies that the borrowers will receive will come to them "tax-free" to use at their discretion. These funds can be taken out as a lump-sum advance or monthly payment. Better yet, these funds can be used as a line-of-credit with an annual growth rate, allowing you to draw tax-free cash in any amount for a worry-free retirement.',
              ),
              const SizedBox(height: 16),
              _bodyText(
                'The New Reverse Mortgage is not like the old one. The federal government has instituted checks and balances to make sure the potential borrower has made informed decision prior to obtaining a reverse mortgage. For your protection a borrower must undergo reverse mortgage counseling with a HUD-approved reverse mortgage counselor. With the advantage of this additional information you will come to realize the New Reverse Mortgage is one of the safest mortgages for baby boomers and seniors.',
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  AppImages.aboutUS,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              _sectionTitle('Find Out How Much Tax-Free Cash* You\'ll Receive'),
              const SizedBox(height: 10),
              _bodyText(
                'Under normal circumstances you can expect to receive anywhere from 45% to 75% of the value of your home. The amount of your tax-free cash* is calculated based upon a combination of three (3) important factors: age of the youngest borrower, the value of your home, and the interest rate at the time you begin your reverse mortgage. We encourage you to call us at 1-800-800-2180 for us to help you to find out how much cash you qualify to receive.',
              ),
              const SizedBox(height: 20),
              _sectionTitle('Learn the Best Way to Receive Your Payout'),
              const SizedBox(height: 10),
              _bodyText(
                'Reverse Mortgage Expert, Robert Rosa, explains, "The income received from a Reverse Mortgage is not taxed and does not affect most Social Security or Medicare benefits. However, Medicaid and SSI benefits could be affected if you don\'t use your income from the Reverse Mortgage immediately. Why do I say that? Because the money you keep in the Bank is counted as an asset. Therefore, if you receive income from your Reverse Mortgage and it is not used by the end of the calendar month, you may exceed the maximum assets allowable. This may cause you to be ineligible to receive these benefits. I advise our clients to choose the line-of-credit option, taking money out on an \'as needed basis\'. It would be spent by the end of the calendar month and not counted as an asset. Our company, Reverse Mortgage Educators, is here to help you to make the right decisions."',
              ),
              const SizedBox(height: 20),
              _sectionTitle(
                  'Learn How to Downsize Utilizing The New Reverse-Mortgage-for-Purchase Plan'),
              const SizedBox(height: 10),
              _bodyText(
                'Congress passed the Reverse-Mortgage-For-Purchase Plan allowing seniors to purchase a new home and only use a portion of the current home\'s sale proceeds as a down payment towards a downsized home. The Reverse Mortgage picks up the difference and there are no monthly mortgage payments. This plan is ideal for seniors who want to downsize but don\'t have enough cash to purchase a new home outright.',
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.blue300,
        fontSize: 15,
        fontWeight: FontWeight.bold,
        height: 1.4,
      ),
    );
  }

  Widget _bodyText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.white,
        fontSize: 13,
        height: 1.6,
      ),
    );
  }
}
