import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/core/services/token_service.dart';
import 'package:reverse_mortage_loan_app/shared/app_image/app_images.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/logo/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (TokenService().hasToken()) {
        Get.offNamed(RouteNames.userHome);
      } else {
        Get.offNamed(RouteNames.chooseAccount);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppImages.launcherIcons,
              width: screenWidth * 0.6,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            SvgPicture.asset(
              AppImages.launcherIconsText,
              width: screenWidth * 0.7,
            ),
          ],
        ),
      ),
    );
  }
}
