import 'package:flutter/material.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class LoanEstimateCard extends StatelessWidget {
  final String title;
  final String loanAmount;
  final String? cashAvailable;
  final String? cashAvailableLabel;
  final String? downPayment;

  const LoanEstimateCard({
    super.key,
    required this.title,
    required this.loanAmount,
    this.cashAvailable,
    this.cashAvailableLabel,
    this.downPayment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.containerHighlight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.yellow500,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            spacing: 20,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Loan Amount',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        loanAmount,
                        style: const TextStyle(
                          color: AppColors.green500,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (cashAvailable != null)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cashAvailableLabel ?? 'Cash Available',
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          cashAvailable!,
                          style: const TextStyle(
                            color: AppColors.green500,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (downPayment != null)
                Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Down Payment',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        downPayment!,
                        style: const TextStyle(
                          color: AppColors.green500,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
