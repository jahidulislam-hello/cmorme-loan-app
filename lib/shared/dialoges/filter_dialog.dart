import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_button.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_date_picker_field.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_dropdown_field.dart';

class FilterDialog extends StatelessWidget {
  final Function(String? objective, DateTime? date)? onConfirm;

  FilterDialog({super.key, this.onConfirm});

  final _selectedObjective = Rxn<String>();
  final _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Material(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: AppColors.containerHighlight,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => CustomDropdownField(
                label: 'Loan Objective',
                labelColor: AppColors.blue300,
                value: _selectedObjective.value,
                items: const [
                  'Reverse Finance ',
                  'Reverse for Purchase',
                ],
                onChanged: (value) => _selectedObjective.value = value,
              )),
              const SizedBox(height: 20),
              CustomDatePickerField(
                label: 'Date',
                labelColor: AppColors.blue300,
                controller: _dateController,
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Confirm',
                onPressed: () {
                  Get.back();
                  DateTime? parsedDate;
                  final dateText = _dateController.text.trim();
                  if (dateText.isNotEmpty) {
                    parsedDate = DateFormat('dd/MM/yyyy').parse(dateText);
                  }
                  onConfirm?.call(_selectedObjective.value, parsedDate);
                },
                textColor: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
