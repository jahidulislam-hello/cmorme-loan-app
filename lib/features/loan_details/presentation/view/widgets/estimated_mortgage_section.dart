import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reverse_mortage_loan_app/shared/app_image/app_images.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class EstimatedMortgageSection extends StatelessWidget {
  final String title;
  final String primaryLabel;
  final String primaryIconPath;
  final String primaryAmount;
  final String cashAvailable;
  final String? downPayment;

  const EstimatedMortgageSection({
    super.key,
    required this.title,
    required this.primaryLabel,
    required this.primaryIconPath,
    required this.primaryAmount,
    required this.cashAvailable,
    this.downPayment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.hintGrey,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _MetricCard(
                iconPath: primaryIconPath,
                label: primaryLabel,
                amount: primaryAmount,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: downPayment != null
                  ? _MetricCard(
                      iconPath: AppImages.downPay,
                      label: 'Down-Payment',
                      amount: downPayment!,
                    )
                  : _MetricCard(
                      iconPath: AppImages.cashIcon,
                      label: 'Cash Available',
                      amount: cashAvailable,
                    ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String iconPath;
  final String label;
  final String amount;

  const _MetricCard({
    required this.iconPath,
    required this.label,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
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
              SvgPicture.asset(iconPath, width: 16, height: 16),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  style: const TextStyle(
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
            amount,
            style: const TextStyle(
              color: AppColors.lightBlue,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
