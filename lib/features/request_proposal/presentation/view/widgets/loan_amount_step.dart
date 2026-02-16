import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reverse_mortage_loan_app/shared/app_image/app_images.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_date_picker_field.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_price_field.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/presentation/view/controller/request_proposal_controller.dart';

class LoanAmountStep extends StatelessWidget {
  final RequestProposalController controller;

  const LoanAmountStep({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(AppImages.detailsIcon, width: 22, height: 22),
            const SizedBox(width: 8),
            const Text(
              'Details for Loan Amount',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        CustomPriceField(
          label: 'Home Value',
          labelColor: AppColors.white,
          controller: controller.homeValueController,
        ),
        const SizedBox(height: 20),
        CustomDatePickerField(
          label: 'Date of Birth',
          labelColor: AppColors.white,
          controller: controller.dobController,
        ),
      ],
    );
  }
}
