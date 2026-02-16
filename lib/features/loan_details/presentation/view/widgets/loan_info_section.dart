import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reverse_mortage_loan_app/shared/app_image/app_images.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class LoanInfoSection extends StatelessWidget {
  final String date;
  final String objective;
  final String loanType;
  final String loanAmount;
  final String? downPayment;

  const LoanInfoSection({
    super.key,
    required this.date,
    required this.objective,
    required this.loanType,
    required this.loanAmount,
    this.downPayment,
  });

  @override
  Widget build(BuildContext context) {
    final bool isGovernment = loanType == 'Government';

    return Column(
      children: [
        _buildInfoRow(AppImages.dateIcon, 'Date', date),
        const SizedBox(height: 12),
        _buildInfoRow(AppImages.objectiveIcon, 'Objective', objective),
        const SizedBox(height: 12),
        _buildLoanTypeRow(isGovernment),
        const SizedBox(height: 12),
        _buildAmountRow(AppImages.loanAmountIcon, 'Loan Amount', loanAmount),
        if (downPayment != null) ...[
          const SizedBox(height: 12),
          _buildAmountRow(AppImages.loanAmountIcon, 'Down-Payment', downPayment!),
        ],
      ],
    );
  }

  Widget _buildInfoRow(String svgPath, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(svgPath, width: 18, height: 18),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.hintGrey,
                fontSize: 14,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildLoanTypeRow(bool isGovernment) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(AppImages.loanTypeIcon, width: 18, height: 18),
            const SizedBox(width: 6),
            const Text(
              'Loan Type',
              style: TextStyle(
                color: AppColors.hintGrey,
                fontSize: 14,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: isGovernment ? AppColors.green600 : AppColors.accentBlue,
              width: 1,
            ),
          ),
          child: Text(
            loanType,
            style: TextStyle(
              color: isGovernment ? AppColors.green500 : AppColors.accentBlue,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAmountRow(String svgPath, String label, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(svgPath, width: 18, height: 18),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.hintGrey,
                fontSize: 14,
              ),
            ),
          ],
        ),
        Text(
          amount,
          style: const TextStyle(
            color: AppColors.green500,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
