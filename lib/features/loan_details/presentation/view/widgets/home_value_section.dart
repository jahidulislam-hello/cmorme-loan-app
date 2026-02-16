import 'package:flutter/material.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class HomeValueSection extends StatelessWidget {
  final String homeValue;

  const HomeValueSection({
    super.key,
    required this.homeValue,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.containerHighlight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('🏠', style: TextStyle(fontSize: 13)),
                SizedBox(width: 6),
                Text(
                  'Home Value',
                  style: TextStyle(
                    color: AppColors.hintGrey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              homeValue,
              style: const TextStyle(
                color: AppColors.green500,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
