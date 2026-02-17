import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reverse_mortage_loan_app/shared/app_image/app_images.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_horizontal_line.dart';

class InboxItem extends StatelessWidget {
  final String userName;
  final String email;
  final String date;
  final String tag;
  final String scenarioText;
  final VoidCallback? onViewDetails;
  final VoidCallback? onDelete;

  const InboxItem({
    super.key,
    required this.userName,
    required this.email,
    required this.date,
    required this.tag,
    required this.scenarioText,
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
          /// Name, Email & Date + Tag
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      email,
                      style: const TextStyle(
                        color: AppColors.hintGrey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const Text(
                        '📅',
                        style: TextStyle(fontSize: 14),
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
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: AppColors.green500,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(
                        color: AppColors.green500,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          /// Calculated by scenario
          Row(
            children: [
              SvgPicture.asset(
                AppImages.loanIcon,
                width: 18,
                height: 18,
              ),
              const SizedBox(width: 8),
              Text(
                scenarioText,
                style: const TextStyle(
                  color: AppColors.yellow500,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const CustomHorizontalLine(thickness: 2),
          const SizedBox(height: 12),

          /// View Details & Delete
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
              GestureDetector(
                onTap: onDelete,
                child: SvgPicture.asset(
                  AppImages.deleteIcon,
                  width: 20,
                  height: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
