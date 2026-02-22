import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/shared/app_image/app_images.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_button.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/presentation/view/controller/request_proposal_controller.dart';

class InquiryPage extends GetView<RequestProposalController> {
  const InquiryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.chevron_left, color: AppColors.white, size: 30),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: const Text(
          'Request Full Proposal',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AppImages.detailsIcon,
                              width: 22, height: 22),
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
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CustomButton(
                  text: 'Next',
                  onPressed: controller.goToAppointment,
                  backgroundColor: AppColors.buttonBlue,
                  textColor: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
