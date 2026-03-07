import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/shared/app_image/app_images.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_button.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_text_field.dart';
import 'package:reverse_mortage_loan_app/features/profile/presentation/view/controller/edit_profile_controller.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  const EditProfileScreen({super.key});

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
          'Edit Profile',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 24),
              CustomTextField(
                label: 'First Name',
                hintText: 'Enter your first name',
                prefixImagePath: AppImages.frame,
                controller: controller.firstNameController,
              ),
              const SizedBox(height: 24),
              CustomTextField(
                label: 'Last Name',
                hintText: 'Enter your last name',
                prefixImagePath: AppImages.frame,
                controller: controller.lastNameController,
              ),
              const Spacer(),
              Obx(() => CustomButton(
                    text: 'Update',
                    onPressed: controller.onUpdate,
                    isLoading: controller.isLoading.value,
                    textColor: AppColors.primary,
                  )),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
