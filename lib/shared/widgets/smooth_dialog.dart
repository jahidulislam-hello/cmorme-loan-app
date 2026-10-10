import 'package:flutter/material.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

Future<void> showSmoothInfoDialog({
  required BuildContext context,
  required String title,
  required String content,
}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 260),
    pageBuilder: (ctx, _, __) => AlertDialog(
      backgroundColor: AppColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        content,
        style: const TextStyle(
          color: AppColors.hintGrey,
          fontSize: 14,
          height: 1.5,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: const Text('Got it',
              style: TextStyle(color: AppColors.green500)),
        ),
      ],
    ),
    transitionBuilder: (_, anim, __, child) => FadeTransition(
      opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.88, end: 1.0).animate(
          CurvedAnimation(parent: anim, curve: Curves.easeOutBack),
        ),
        child: child,
      ),
    ),
  );
}
