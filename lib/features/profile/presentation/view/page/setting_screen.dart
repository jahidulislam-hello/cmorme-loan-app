import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/features/profile/presentation/view/controller/setting_controller.dart';
import 'package:reverse_mortage_loan_app/features/profile/presentation/view/widgets/profile_option_container.dart';

class SettingScreen extends GetView<SettingController> {
  const SettingScreen({super.key});

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
          'Setting',
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
              const SizedBox(height: 16),
              ProfileOptionContainer(
                title: 'Change Password',
                onTap: controller.onChangePassword,
              ),
              const SizedBox(height: 16),
              ProfileOptionContainer(
                title: 'Terms & Condition',
                onTap: controller.onTermsAndCondition,
              ),
              const SizedBox(height: 16),
              ProfileOptionContainer(
                title: 'Privacy Policy',
                onTap: controller.onPrivacyPolicy,
              ),
              const SizedBox(height: 16),
              ProfileOptionContainer(
                title: 'About Us',
                onTap: controller.onAboutUs,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
