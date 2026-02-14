import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/shared/app_image/app_images.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_button.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/logo/app_logo.dart';
import 'controller/auth_controller.dart';

class ChooseAccountScreen extends GetView<AuthController> {
  const ChooseAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const AppLogo(width: 238, height: 225),
                  const Spacer(),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: ClipPath(
              clipper: _CurvedTopClipper(),
              child: Container(
                color: AppColors.blue400,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'App allows users to calculate loan base method\nwith show the amount.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.blue100,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Choose your role to get started',
                      style: TextStyle(
                        color: AppColors.blue500,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomButton(
                      text: 'As a User Account',
                      onPressed: controller.chooseUserAccount,
                      isOutlined: true,
                      imagePath: AppImages.group,
                      textColor: AppColors.primary,
                    ),
                    const SizedBox(height: 16),
                    CustomButton(
                      text: 'As a Real State Account',
                      onPressed: controller.chooseRealStateAccount,
                      isOutlined: true,
                      imagePath: AppImages.layer,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CurvedTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(size.width / 2, 80, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
