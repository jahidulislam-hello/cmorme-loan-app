import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reverse_mortage_loan_app/shared/app_image/app_images.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/presentation/view/controller/request_proposal_controller.dart';

class InquiryStep extends StatelessWidget {
  final RequestProposalController controller;

  const InquiryStep({super.key, required this.controller});

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
              'Inquiry',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Do you have any specific question?',
          style: TextStyle(
            color: AppColors.hintGrey,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: controller.inquiryController,
          maxLines: 5,
          cursorColor: AppColors.white,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: 'Write your question...',
            hintStyle: const TextStyle(
              color: AppColors.hintGrey,
              fontSize: 14,
            ),
            filled: true,
            fillColor: AppColors.containerHighlight,
            contentPadding: const EdgeInsets.all(14),
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
          ),
        ),
      ],
    );
  }
}
