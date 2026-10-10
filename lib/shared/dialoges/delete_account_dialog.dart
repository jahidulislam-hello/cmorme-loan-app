import 'package:flutter/material.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_button.dart';

class DeleteAccountDialog extends StatelessWidget {
  final VoidCallback onDelete;

  const DeleteAccountDialog({
    super.key,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.containerHighlight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Delete Account',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 28,
                  height: 28,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.hintGrey,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            const Text(
              'Are you sure you want to delete your account? This action cannot be undone.',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 14,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Cancel',
                    onPressed: () => Navigator.of(context).pop(),
                    textColor: AppColors.primary,
                    backgroundColor: AppColors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomButton(
                    text: 'Delete',
                    onPressed: onDelete,
                    backgroundColor: Colors.redAccent,
                    textColor: AppColors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
