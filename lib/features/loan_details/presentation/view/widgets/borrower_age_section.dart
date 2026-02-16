import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reverse_mortage_loan_app/shared/app_image/app_images.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class BorrowerAgeSection extends StatelessWidget {
  final String firstBorrowerAge;
  final String? secondBorrowerAge;

  const BorrowerAgeSection({
    super.key,
    required this.firstBorrowerAge,
    this.secondBorrowerAge,
  });

  bool get hasTwoBorrowers => secondBorrowerAge != null;

  @override
  Widget build(BuildContext context) {
    if (hasTwoBorrowers) {
      return _buildDualBorrowerCard();
    }
    return _buildSingleBorrowerCard();
  }

  Widget _buildSingleBorrowerCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.containerHighlight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(AppImages.borrowerIcon, width: 16, height: 16),
              const SizedBox(width: 6),
              const Text(
                'Borrower Age',
                style: TextStyle(
                  color: AppColors.hintGrey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            firstBorrowerAge,
            style: const TextStyle(
              color: AppColors.accentBlue,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDualBorrowerCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.containerHighlight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(AppImages.borrowerIcon, width: 16, height: 16),
                      const SizedBox(width: 6),
                      const Flexible(
                        child: Text(
                          '1st Borrower Age',
                          style: TextStyle(
                            color: AppColors.hintGrey,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    firstBorrowerAge,
                    style: const TextStyle(
                      color: AppColors.accentBlue,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 1,
              margin: const EdgeInsets.symmetric(horizontal: 14),
              color: AppColors.primary,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(AppImages.borrowerIcon, width: 16, height: 16),
                      const SizedBox(width: 6),
                      const Flexible(
                        child: Text(
                          '2nd Borrower Age',
                          style: TextStyle(
                            color: AppColors.hintGrey,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    secondBorrowerAge!,
                    style: const TextStyle(
                      color: AppColors.accentBlue,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
