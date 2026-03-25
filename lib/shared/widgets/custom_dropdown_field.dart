import 'package:flutter/material.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final Color? labelColor;
  final Color? dropdownMenuColor;
  final Color? dropdownItemTextColor;
  final bool showItemDivider;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    this.value,
    this.labelColor,
    this.dropdownMenuColor,
    this.dropdownItemTextColor,
    this.showItemDivider = false,
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
        LayoutBuilder(
          builder: (context, constraints) {
            return DropdownMenu<String>(
              key: ValueKey(value),
              initialSelection: value,
              width: constraints.maxWidth,
              enableSearch: false,
              requestFocusOnTap: false,
              menuStyle: MenuStyle(
                alignment: Alignment.bottomRight,
                backgroundColor: WidgetStatePropertyAll(
                  dropdownMenuColor ?? AppColors.containerHighlight,
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                elevation: const WidgetStatePropertyAll(4),
                visualDensity: VisualDensity.compact,
              ),
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: AppColors.containerHighlight,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                hintStyle: const TextStyle(
                  color: AppColors.hintGrey,
                  fontSize: 14,
                ),
              ),
              trailingIcon: const Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.hintGrey,
              ),
              selectedTrailingIcon: const Icon(
                Icons.keyboard_arrow_up,
                color: AppColors.hintGrey,
              ),
              hintText: 'Select',
              textStyle: const TextStyle(
                color: AppColors.white,
                fontSize: 14,
              ),
              dropdownMenuEntries: _buildEntries(),
              onSelected: onChanged,
            );
          },
        ),
      ],
    );
  }

  List<DropdownMenuEntry<String>> _buildEntries() {
    final entries = <DropdownMenuEntry<String>>[];
    for (int i = 0; i < items.length; i++) {
      entries.add(
        DropdownMenuEntry<String>(
          value: items[i],
          label: items[i],
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(
              dropdownItemTextColor ?? AppColors.white,
            ),
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
        ),
      );
      // Insert a thin divider after every item except the last
      if (showItemDivider && i < items.length - 1) {
        entries.add(
          DropdownMenuEntry<String>(
            value: '__divider_${i}__',
            label: '',
            enabled: false,
            style: const ButtonStyle(
              minimumSize: WidgetStatePropertyAll(Size(0, 1)),
              padding: WidgetStatePropertyAll(EdgeInsets.zero),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            labelWidget: const Divider(
              color: AppColors.hintGrey,
              thickness: 1,
              height: 1,
            ),
          ),
        );
      }
    }
    return entries;
  }
}
