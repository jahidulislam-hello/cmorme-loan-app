import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class ProfileOptionContainer extends StatelessWidget {
  final String? iconPath;
  final String title;
  final VoidCallback? onTap;

  const ProfileOptionContainer({
    super.key,
    this.iconPath,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.containerHighlight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            if (iconPath != null) ...[
              SvgPicture.asset(
                iconPath!,
                width: 22,
                height: 22,
                colorFilter: const ColorFilter.mode(
                  AppColors.white,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.white,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
