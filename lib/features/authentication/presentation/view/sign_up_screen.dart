import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/shared/app_image/app_images.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_button.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_text_field.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/logo/app_logo.dart';
import 'controller/auth_controller.dart';

class SignUpScreen extends GetView<AuthController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const AppLogo(width: 80, height: 80),
              const SizedBox(height: 24),
              const Text(
                'Sign Up',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              Obx(() => CustomTextField(
                    label: 'First Name',
                    hintText: 'Enter your first name',
                    prefixImagePath: AppImages.frame,
                    controller: controller.firstNameController,
                    errorText: controller.firstNameError.value,
                    onChanged: (_) => controller.firstNameError.value = null,
                  )),
              const SizedBox(height: 16),
              Obx(() => CustomTextField(
                    label: 'Last Name',
                    hintText: 'Enter your last name',
                    prefixImagePath: AppImages.frame,
                    controller: controller.lastNameController,
                    errorText: controller.lastNameError.value,
                    onChanged: (_) => controller.lastNameError.value = null,
                  )),
              const SizedBox(height: 16),
              Obx(() => CustomTextField(
                    label: 'Email',
                    hintText: 'Enter your mail',
                    prefixImagePath: AppImages.mail,
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    errorText: controller.emailError.value,
                    onChanged: (_) => controller.emailError.value = null,
                  )),
              const SizedBox(height: 16),
              Obx(() => CustomTextField(
                    label: 'Password',
                    hintText: 'Enter your password',
                    prefixImagePath: AppImages.lock,
                    isPassword: true,
                    obscureText: controller.obscurePassword.value,
                    onTogglePassword: controller.togglePasswordVisibility,
                    controller: controller.passwordController,
                    errorText: controller.passwordError.value,
                    onChanged: (_) => controller.passwordError.value = null,
                  )),
              const SizedBox(height: 16),
              Obx(() => CustomTextField(
                    label: 'Confirm Password',
                    hintText: 'Enter your password',
                    prefixImagePath: AppImages.lock,
                    isPassword: true,
                    obscureText: controller.obscureConfirmPassword.value,
                    onTogglePassword: controller.toggleConfirmPasswordVisibility,
                    controller: controller.confirmPasswordController,
                    errorText: controller.confirmPasswordError.value,
                    onChanged: (_) => controller.confirmPasswordError.value = null,
                  )),
              const SizedBox(height: 32),
              Obx(() => CustomButton(
                    text: 'Create Account',
                    onPressed: controller.signUp,
                    isLoading: controller.isLoading.value,
                    textColor: AppColors.primary,
                  )),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an Account? ',
                    style: TextStyle(color: AppColors.hintGrey, fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(RouteNames.signIn),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
