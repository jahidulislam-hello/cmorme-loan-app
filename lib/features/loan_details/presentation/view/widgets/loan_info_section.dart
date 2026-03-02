import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reverse_mortage_loan_app/shared/app_image/app_images.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class LoanInfoSection extends StatelessWidget {
  final String date;
  final String objective;
  final String homeValue;
  final String firstBorrowerAge;
  final String? secondBorrowerAge;

  const LoanInfoSection({
    super.key,
    required this.date,
    required this.objective,
    required this.homeValue,
    required this.firstBorrowerAge,
    this.secondBorrowerAge,
  });

  bool get hasTwoBorrowers => secondBorrowerAge != null;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildInfoRow(AppImages.dateIcon, 'Date', date, AppColors.white),
        const SizedBox(height: 12),
        _buildInfoRow(AppImages.objectiveIcon, 'Objective', objective, AppColors.white),
        const SizedBox(height: 12),
        _buildInfoRow(AppImages.homeIcon, 'Home Value', homeValue, AppColors.green500),
        const SizedBox(height: 12),
        if (hasTwoBorrowers) ...[
          _buildInfoRow(AppImages.borrowerIcon, '1st Borrower Age', firstBorrowerAge, AppColors.white),
          const SizedBox(height: 12),
          _buildInfoRow(AppImages.borrowerIcon, '2nd Borrower Age', secondBorrowerAge!, AppColors.white),
        ] else
          _buildInfoRow(AppImages.borrowerIcon, 'Borrower Age', firstBorrowerAge, AppColors.white),
      ],
    );
  }

  Widget _buildInfoRow(String svgPath, String label, String value, Color valueColor) {
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
          style: TextStyle(
            color: valueColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
