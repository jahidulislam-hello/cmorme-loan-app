import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/shared/app_image/app_images.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_button.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_text_field.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/logo/app_logo.dart';
import 'controller/auth_controller.dart';

class VerifyEmailScreen extends GetView<AuthController> {
  const VerifyEmailScreen({super.key});

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
                      const AppLogo(width: 80, height: 80),
                      const SizedBox(height: 24),

                      const Text(
                        'Verify',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 32),

                      CustomTextField(
                        label: 'Email',
                        hintText: 'demo@email.com',
                        prefixImagePath: AppImages.mail,
                        controller: controller.verifyEmailController,
                        keyboardType: TextInputType.emailAddress,
                      ),

                      const Spacer(),

                      CustomButton(
                        text: 'Confirm',
                        onPressed: controller.verifyEmail,
                        textColor: AppColors.primary,
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

