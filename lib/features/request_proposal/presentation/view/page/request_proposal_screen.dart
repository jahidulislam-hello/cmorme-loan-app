import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_button.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_step_progress.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/presentation/view/controller/request_proposal_controller.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/presentation/view/widgets/basic_info_step.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/presentation/view/widgets/interested_step.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/presentation/view/widgets/loan_amount_step.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/presentation/view/widgets/inquiry_step.dart';

class RequestProposalScreen extends GetView<RequestProposalController> {
  const RequestProposalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: AppColors.white, size: 30),
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
              const SizedBox(height: 8),
              Obx(() => CustomStepProgress(
                totalSteps: 4,
                currentStep: controller.currentStep.value,
                onStepTap: controller.goToStep,
              )),
              const SizedBox(height: 32),
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    BasicInfoStep(controller: controller),
                    InterestedStep(controller: controller),
                    LoanAmountStep(controller: controller),
                    InquiryStep(controller: controller),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Obx(() {
                  final isLastStep = controller.currentStep.value == 3;
                  if (isLastStep) {
                    return CustomButton(
                      text: 'Send',
                      onPressed: controller.onSend,
                      textColor: AppColors.primary,
                    );
                  }
                  return Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: controller.nextStep,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: AppColors.containerHighlight,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.chevron_right,
                          color: AppColors.blue400,
                          size: 28,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
