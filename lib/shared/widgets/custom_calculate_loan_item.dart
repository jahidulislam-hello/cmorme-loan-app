import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reverse_mortage_loan_app/shared/app_image/app_images.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_button.dart';

class CustomCalculateLoanItem extends StatelessWidget {
  final VoidCallback onStartPressed;

  const CustomCalculateLoanItem({
    super.key,
    required this.onStartPressed,
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
            'Calculate Your Loan',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Calculate loan amounts instantly based on\nuser input such as age, property value, and\nselected interest rate',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.hintGrey,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: 'Start',
            onPressed: onStartPressed,
            backgroundColor: AppColors.green500,
            textColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
