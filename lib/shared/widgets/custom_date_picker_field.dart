import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class CustomDatePickerField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final Color? labelColor;

  const CustomDatePickerField({
    super.key,
    required this.label,
    this.hintText = 'Date',
    this.controller,
    this.labelColor,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.buttonBlue,
              onPrimary: AppColors.white,
              surface: AppColors.containerHighlight,
              onSurface: AppColors.white,
            ),
            dialogBackgroundColor: AppColors.primary,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.white,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && controller != null) {
      controller!.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

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
        GestureDetector(
          onTap: () => _selectDate(context),
          child: AbsorbPointer(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.containerHighlight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: controller,
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
                    Icons.calendar_today_outlined,
                    color: AppColors.hintGrey,
                    size: 20,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
