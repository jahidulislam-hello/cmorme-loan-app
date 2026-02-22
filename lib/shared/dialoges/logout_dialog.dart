import 'package:flutter/material.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_button.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onLogout;

  const LogoutDialog({
    super.key,
    required this.onLogout,
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
            /// Title & Close
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Log Out',
                  style: TextStyle(
                    color: AppColors.white,
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

            /// Description
            const Text(
              'Are you sure you want to log out your account?',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 24),

            /// Buttons
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'NO',
                    onPressed: () => Navigator.of(context).pop(),
                  //  isOutlined: true,
                    textColor: AppColors.primary,
                    backgroundColor: AppColors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomButton(
                    text: 'Yes',
                    onPressed: onLogout,
                    backgroundColor: AppColors.buttonBlue,
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
