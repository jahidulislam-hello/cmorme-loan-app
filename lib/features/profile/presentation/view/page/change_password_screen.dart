import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/shared/app_image/app_images.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_button.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_text_field.dart';
import 'package:reverse_mortage_loan_app/features/profile/presentation/view/controller/change_password_controller.dart';

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  const ChangePasswordScreen({super.key});

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
          'Change Password',
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
              Obx(() => CustomTextField(
                label: 'Password',
                hintText: 'Enter your password',
                prefixImagePath: AppImages.lock,
                controller: controller.passwordController,
                isPassword: true,
                obscureText: controller.obscurePassword.value,
                onTogglePassword: controller.togglePasswordVisibility,
              )),
              const SizedBox(height: 24),
              Obx(() => CustomTextField(
                label: 'Confirm Password',
                hintText: 'Enter your password',
                prefixImagePath: AppImages.lock,
                controller: controller.confirmPasswordController,
                isPassword: true,
                obscureText: controller.obscureConfirmPassword.value,
                onTogglePassword: controller.toggleConfirmPasswordVisibility,
              )),
              const Spacer(),
              CustomButton(
                text: 'Update',
                onPressed: controller.onUpdate,
                textColor: AppColors.primary,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
