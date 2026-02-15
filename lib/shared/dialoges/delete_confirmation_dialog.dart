import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reverse_mortage_loan_app/shared/app_image/app_images.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_button.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final VoidCallback onDelete;

  const DeleteConfirmationDialog({
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
          children: [
            /// Close Button
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
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
            ),

            const SizedBox(height: 8),

            /// Trash Icon
            SvgPicture.asset(
              AppImages.deleteIcon,
              width: 40,
              height: 40,
            ),

            const SizedBox(height: 16),

            /// Title
            const Text(
              'Delete the data',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 24),

            /// Delete Button
            CustomButton(
              text: 'Delete',
              onPressed: onDelete,
              textColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
