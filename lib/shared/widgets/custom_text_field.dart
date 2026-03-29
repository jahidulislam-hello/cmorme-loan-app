import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData? prefixIcon;
  final String? prefixImagePath;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onTogglePassword;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Color? labelColor;
  final double? labelFontSize;
  final Color? textColor;
  final double? textFontSize;
  final bool filled;
  final Color? backgroundColor;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.prefixIcon,
    this.prefixImagePath,
    this.isPassword = false,
    this.obscureText = false,
    this.onTogglePassword,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.labelColor,
    this.labelFontSize,
    this.textColor,
    this.textFontSize,
    this.filled = false,
    this.backgroundColor,
    this.errorText,
    this.onChanged,
  });

  Widget? _buildPrefixIcon() {
    if (prefixImagePath != null) {
      final Widget image;
      if (prefixImagePath!.endsWith('.svg')) {
        image = SvgPicture.asset(prefixImagePath!, width: 20, height: 20);
      } else {
        image = Image.asset(prefixImagePath!, width: 20, height: 20);
      }
      return Padding(
        padding: const EdgeInsets.all(12),
        child: image,
      );
    }
    if (prefixIcon != null) {
      return Icon(prefixIcon, color: AppColors.hintGrey, size: 20);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final hasError = errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: labelColor ?? AppColors.hintGrey,
            fontSize: labelFontSize ?? 13,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          cursorColor: AppColors.white,
          onChanged: onChanged,
          style: TextStyle(
            color: textColor ?? AppColors.white,
            fontSize: textFontSize ?? 14,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: AppColors.hintGrey,
              fontSize: 14,
            ),
            prefixIcon: _buildPrefixIcon(),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.hintGrey,
                      size: 20,
                    ),
                    onPressed: onTogglePassword,
                  )
                : null,
            filled: filled,
            fillColor: backgroundColor,
            contentPadding: EdgeInsets.symmetric(
              horizontal: filled ? 12 : 0,
              vertical: 14,
            ),
            enabledBorder: filled
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: hasError
                        ? const BorderSide(color: Colors.redAccent, width: 1.5)
                        : BorderSide.none,
                  )
                : UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: hasError ? Colors.redAccent : AppColors.fieldBorder,
                      width: 1,
                    ),
                  ),
            focusedBorder: filled
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: hasError
                        ? const BorderSide(color: Colors.redAccent, width: 1.5)
                        : BorderSide.none,
                  )
                : UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: hasError ? Colors.redAccent : AppColors.buttonBlue,
                      width: 1,
                    ),
                  ),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 6),
          Text(
            errorText!,
            style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }
}
