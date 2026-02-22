import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reverse_mortage_loan_app/shared/app_image/app_images.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_horizontal_line.dart';

class CustomCalculationItem extends StatelessWidget {
  final String date;
  final String tag;
  final String loanAmount;
  final String cashAvailable;
  final String? downPayment;
  final VoidCallback? onViewDetails;
  final VoidCallback? onDelete;

  const CustomCalculationItem({
    super.key,
    required this.date,
    required this.tag,
    required this.loanAmount,
    required this.cashAvailable,
    this.downPayment,
    this.onViewDetails,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.containerHighlight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Date & Tag row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    AppImages.date
                  ),
                  const SizedBox(width: 6),
                  Text(
                    date,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: tag == 'Reverse for Purchase'
                        ? const Color(0xFFDEA400)
                        : AppColors.green600,
                    width: 1,
                  ),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    color: tag == 'Reverse for Purchase'
                        ? const Color(0xFFDEA400)
                        : AppColors.green500,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          /// Loan Amount & Cash Available row
          Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppImages.loan,
                        width: 14,
                        height: 14,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Loan Amount',
                        style: TextStyle(
                          color: AppColors.hintGrey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$$loanAmount',
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppImages.cashIcon,
                        width: 14,
                        height: 14,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Cash Available',
                        style: TextStyle(
                          color: AppColors.hintGrey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$$cashAvailable',
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              if (downPayment != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppImages.downPay,
                          width: 14,
                          height: 14,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Down Pay',
                          style: TextStyle(
                            color: AppColors.hintGrey,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$$downPayment',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 16),
          const CustomHorizontalLine(
            thickness: 2,
          ),
          const SizedBox(height: 16),

          /// View Details & Delete row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onViewDetails,
                child: const Text(
                  'View Details',
                  style: TextStyle(
                    color: AppColors.accentBlue,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                width: 28,
                height: 28,
                child: IconButton(
                  onPressed: onDelete,
                  padding: EdgeInsets.zero,
                  icon: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(
                      CupertinoIcons.delete,
                      color: AppColors.white,
                      size: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
