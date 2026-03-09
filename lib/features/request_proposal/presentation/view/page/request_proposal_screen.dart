import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_button.dart';
// import 'package:reverse_mortage_loan_app/shared/widgets/custom_step_progress.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_text_field.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/presentation/view/controller/request_proposal_controller.dart';

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
              const SizedBox(height: 8),
              // Obx(() => CustomStepProgress(
              //   totalSteps: 8,
              //   currentStep: controller.currentStep.value,
              //   onStepTap: controller.goToStep,
              // )),
              const SizedBox(height: 32),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.info_outline,
                              color: AppColors.blue600, size: 24),
                          SizedBox(width: 8),
                          Text(
                            'Basic Information',
                            style: TextStyle(
                              color: AppColors.blue600,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        label: 'Full Name',
                        hintText: 'Full Name',
                        labelColor: AppColors.blue200,
                        controller: controller.fullNameController,
                        filled: true,
                        backgroundColor: AppColors.containerHighlight,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        label: 'Last Name',
                        hintText: 'Last Name',
                        labelColor: AppColors.blue200,
                        controller: controller.lastNameController,
                        filled: true,
                        backgroundColor: AppColors.containerHighlight,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        label: 'Email',
                        hintText: 'Email',
                        labelColor: AppColors.blue200,
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        filled: true,
                        backgroundColor: AppColors.containerHighlight,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Obx(() => CustomButton(
                      text: 'Next',
                      onPressed: controller.goToAddress,
                      backgroundColor: AppColors.buttonBlue,
                      textColor: AppColors.white,
                      isLoading: controller.isLoading.value,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
