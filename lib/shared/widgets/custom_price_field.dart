import 'package:flutter/material.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class CustomPriceField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final Color? labelColor;
  final Color? backgroundColor;
  final bool showBorder;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  const CustomPriceField({
    super.key,
    required this.label,
    this.hintText = '',
    this.controller,
    this.labelColor,
    this.backgroundColor,
    this.showBorder = false,
    this.errorText,
    this.onChanged,
  });

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
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          cursorColor: AppColors.white,
          onChanged: onChanged,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: AppColors.hintGrey,
              fontSize: 14,
            ),
            suffixIcon: const Icon(
              Icons.monetization_on_outlined,
              color: AppColors.hintGrey,
              size: 20,
            ),
            filled: true,
            fillColor: backgroundColor ?? AppColors.containerHighlight,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            enabledBorder: showBorder
                ? UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: hasError ? Colors.redAccent : AppColors.fieldBorder,
                      width: 1,
                    ),
                  )
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: hasError
                        ? const BorderSide(color: Colors.redAccent, width: 1.5)
                        : BorderSide.none,
                  ),
            focusedBorder: showBorder
                ? UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: hasError ? Colors.redAccent : AppColors.buttonBlue,
                      width: 1,
                    ),
                  )
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: hasError
                        ? const BorderSide(color: Colors.redAccent, width: 1.5)
                        : BorderSide.none,
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
