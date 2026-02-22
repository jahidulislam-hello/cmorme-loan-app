import 'package:flutter/material.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class BorrowerToggle extends StatelessWidget {
  final bool isMultipleBorrower;
  final ValueChanged<bool> onChanged;

  const BorrowerToggle({
    super.key,
    required this.isMultipleBorrower,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.fieldBorder,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Row(
          children: [
            _buildTab(
              label: 'Single Borrower',
              isSelected: !isMultipleBorrower,
              onTap: () => onChanged(false),
            ),
            _buildTab(
              label: 'Multiple Borrower',
              isSelected: isMultipleBorrower,
              onTap: () => onChanged(true),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40,
          width: 174,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.blue200 : Colors.transparent,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Text(
            label,
            style: TextStyle(
             // color: AppColors.primary,
              color: isSelected ? AppColors.primary : AppColors.hintGrey,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
