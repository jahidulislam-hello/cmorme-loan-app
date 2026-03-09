import 'package:flutter/material.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class CustomPriceField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final Color? labelColor;
  final Color? backgroundColor;
  final bool showBorder;

  const CustomPriceField({
    super.key,
    required this.label,
    this.hintText = 'Price',
    this.controller,
    this.labelColor,
    this.backgroundColor,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
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
                ? const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.fieldBorder,
                      width: 1,
                    ),
                  )
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
            focusedBorder: showBorder
                ? const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.buttonBlue,
                      width: 1,
                    ),
                  )
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
          ),
        ),
      ],
    );
  }
}
