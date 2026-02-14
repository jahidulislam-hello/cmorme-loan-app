import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/shared/app_image/app_images.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_button.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_text_field.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/logo/app_logo.dart';
import 'controller/auth_controller.dart';

class NewPasswordScreen extends GetView<AuthController> {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const AppLogo(width: 145, height: 137),
              const SizedBox(height: 24),
              const Text(
                'Enter your new password',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              Obx(() => CustomTextField(
                    label: 'Password',
                    hintText: 'Enter your password',
                    prefixImagePath: AppImages.lock,
                    isPassword: true,
                    obscureText: controller.obscureNewPassword.value,
                    onTogglePassword: controller.toggleNewPasswordVisibility,
                    controller: controller.newPasswordController,
                  )),
              const SizedBox(height: 16),
              Obx(() => CustomTextField(
                    label: 'Confirm Password',
                    hintText: 'Enter your password',
                    prefixImagePath: AppImages.lock,
                    isPassword: true,
                    obscureText: controller.obscureNewConfirmPassword.value,
                    onTogglePassword:
                        controller.toggleNewConfirmPasswordVisibility,
                    controller: controller.newConfirmPasswordController,
                  )),
              const SizedBox(height: 32),
              CustomButton(
                text: 'Confirm',
                onPressed: controller.resetPassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
