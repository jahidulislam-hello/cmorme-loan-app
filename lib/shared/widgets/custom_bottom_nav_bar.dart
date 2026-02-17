import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reverse_mortage_loan_app/shared/app_image/app_images.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onTap;

  const CustomBottomNavBar({
    super.key,
    this.selectedIndex = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      AppImages.homeIcon,
      AppImages.inboxIcon,
      AppImages.historyIcon,
      AppImages.avatarIcon,
    ];

    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: AppColors.blue50,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onTap?.call(index),
            behavior: HitTestBehavior.opaque,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  items[index],
                  width: 24,
                  height: 24,
                  // colorFilter: ColorFilter.mode(
                  //   isSelected ? AppColors.accentBlue : AppColors.hintGrey,
                  //   BlendMode.srcIn,
                  // ),
                ),
                if (isSelected) ...[
                  const SizedBox(height: 4),
                  Container(
                    width: 40,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: AppColors.black400,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ],
              ],
            ),
          );
        }),
      ),
    );
  }
}
