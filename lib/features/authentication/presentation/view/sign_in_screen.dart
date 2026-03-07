import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/shared/app_image/app_images.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_button.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_text_field.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/logo/app_logo.dart';
import 'controller/auth_controller.dart';

class SignInScreen extends GetView<AuthController> {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      const AppLogo(width: 145, height: 137),
                      const SizedBox(height: 24),
                      const Text(
                        'Sign In',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 32),

                      /// Email
                      CustomTextField(
                        label: 'Email',
                        hintText: 'demo@email.com',
                       prefixImagePath: AppImages.mail,
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,

                      ),
                      const SizedBox(height: 20),

                      /// Password
                      Obx(() => CustomTextField(
                        label: 'Password',
                        hintText: 'Enter your password',
                       prefixImagePath: AppImages.lock,
                        isPassword: true,
                        obscureText: controller.obscurePassword.value,
                        onTogglePassword:
                        controller.togglePasswordVisibility,
                        controller: controller.passwordController,
                      )),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: controller.goToVerifyEmail,
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      const Spacer(),


                      Obx(() => CustomButton(
                            text: 'Login',
                            onPressed: controller.login,
                            isLoading: controller.isLoading.value,
                            textColor: AppColors.primary,
                          )),
                      const SizedBox(height: 20),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an Account? ",
                            style: TextStyle(
                                color: AppColors.hintGrey, fontSize: 14),
                          ),
                          GestureDetector(
                            onTap: () => Get.toNamed(RouteNames.signUp),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),

    );
  }
}
