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
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: labelColor ?? AppColors.green500,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.blue400,
            borderRadius: BorderRadius.circular(8),

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
                    color: AppColors.white,
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
      ],
    );
  }
}
