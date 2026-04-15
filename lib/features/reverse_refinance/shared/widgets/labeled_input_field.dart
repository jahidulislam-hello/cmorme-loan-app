import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class LabeledInputField extends StatelessWidget {
  final String label;
  final String? hintText;
  final IconData? prefixIcon;
  final String? prefixImagePath;
  final Color? prefixIconColor;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Color? labelColor;
  final String? errorText;
  final String? infoText;

  const LabeledInputField({
    super.key,
    required this.label,
    this.hintText,
    this.prefixIcon,
    this.prefixImagePath,
    this.prefixIconColor,
    this.controller,
    this.keyboardType = TextInputType.number,
    this.labelColor,
    this.errorText,
    this.infoText,
  });

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.blue400,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          label,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          infoText!,
          style: const TextStyle(
            color: AppColors.hintGrey,
            fontSize: 14,
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Got it',
              style: TextStyle(color: AppColors.green500),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: labelColor ?? AppColors.green500,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            if (infoText != null) ...[
              const SizedBox(width: 4),
              GestureDetector(
                onTap: () => _showInfoDialog(context),
                child: const Icon(
                  Icons.info_outline,
                  size: 18,
                  color: AppColors.hintGrey,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.blue400,
            borderRadius: BorderRadius.circular(8),
            border: errorText != null
                ? Border.all(color: Colors.redAccent, width: 1.5)
                : null,
          ),
          child: Row(
            children: [
              if (prefixImagePath != null) ...[
                const SizedBox(width: 12),
                SvgPicture.asset(
                  prefixImagePath!,
                  width: 20,
                  height: 20,

                ),
              ] else if (prefixIcon != null) ...[
                const SizedBox(width: 12),
                Icon(
                  prefixIcon,
                  color: prefixIconColor ?? AppColors.green500,
                  size: 20,
                ),
              ],
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: keyboardType,
                  inputFormatters: keyboardType == TextInputType.number
                      ? [FilteringTextInputFormatter.digitsOnly]
                      : null,
                  style: const TextStyle(
                    color: AppColors.green500,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: const TextStyle(
                      color: AppColors.hintGrey,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  cursorColor: AppColors.white,
                ),
              ),
            ],
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 6),
          Text(
            errorText!,
            style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}
