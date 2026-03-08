import 'package:flutter/material.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_text_field.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/presentation/view/controller/request_proposal_controller.dart';

class BasicInfoStep extends StatelessWidget {
  final RequestProposalController controller;

  const BasicInfoStep({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.blue600, size: 24),
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
            hintText: 'Name',
            labelColor: AppColors.blue200,
            controller: controller.fullNameController,
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
          const SizedBox(height: 20),
          CustomTextField(
            label: 'Address',
            hintText: 'Address',
            labelColor: AppColors.blue200,
            controller: controller.addressController,
            filled: true,
            backgroundColor: AppColors.containerHighlight,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'City',
            hintText: 'City Name',
            labelColor: AppColors.blue200,
            controller: controller.cityController,
            filled: true,
            backgroundColor: AppColors.containerHighlight,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'State Code',
            hintText: 'Code',
            labelColor: AppColors.blue200,
            controller: controller.stateCodeController,
            filled: true,
            backgroundColor: AppColors.containerHighlight,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
