import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reverse_mortage_loan_app/shared/app_image/app_images.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_button.dart';

class CustomCalculateLoanItem extends StatelessWidget {
  final VoidCallback onReverseRefinance;
  final VoidCallback onReverseForPurchase;
  final VoidCallback onReverseMortgageFAQ;

  const CustomCalculateLoanItem({
    super.key,
    required this.onReverseRefinance,
    required this.onReverseForPurchase,
    required this.onReverseMortgageFAQ,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.containerHighlight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          ClipOval(
            child: Container(
              width: 64,
              height: 64,
              color: AppColors.primary,
              padding: const EdgeInsets.all(14),
              child: SvgPicture.asset(
                AppImages.loanIcon,
                width: 36,
                height: 36,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'What would you like to calculate?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          /// Reverse Refinance Button
          _CalculateOptionButton(
            title: 'Reverse Refinance',
            subtitle: 'Stay home, access cash, with monthly mortgage payments',
            onTap: onReverseRefinance,
          ),

          const SizedBox(height: 12),

          /// Reverse for Purchase Button
          _CalculateOptionButton(
            title: 'Reverse for Purchase',
            subtitle:
                'Buy new home & optional or no monthly mortgage payments',
            onTap: onReverseForPurchase,
          ),

         // const SizedBox(height: 12),

          /// Reverse Mortgage FAQ Button

        ],
      ),
    );
  }
}

class _CalculateOptionButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _CalculateOptionButton({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.green500,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.hintGrey.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.primary,
                  size: 22,
                ),

              ],
            ),
            Text(
              subtitle,
              style: const TextStyle(
                color: AppColors.blue400,
                fontSize: 10
               // height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
