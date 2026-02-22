import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/shared/app_image/app_images.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_bottom_nav_bar.dart';
import 'package:reverse_mortage_loan_app/features/profile/presentation/view/controller/account_setting_controller.dart';
import 'package:reverse_mortage_loan_app/features/profile/presentation/view/widgets/profile_option_container.dart';

class AccountSettingScreen extends GetView<AccountSettingController> {
  const AccountSettingScreen({super.key});

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
          'Account Setting',
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
                iconPath: AppImages.profileIcon,
                title: 'Edit Profile',
                onTap: controller.onEditProfile,
              ),
              const SizedBox(height: 16),
              ProfileOptionContainer(
                iconPath: AppImages.settingsIcon,
                title: 'Setting',
                onTap: controller.onSetting,
              ),
              const SizedBox(height: 16),
              ProfileOptionContainer(
                iconPath: AppImages.logout,
                title: 'Log Out',
                onTap: controller.onLogout,

              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(() => CustomBottomNavBar(
        selectedIndex: controller.selectedNavIndex.value,
        onTap: controller.onNavTap,
      )),
    );
  }
}
