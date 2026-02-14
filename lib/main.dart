import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/config/routes/app_router.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Reverse Mortgage Loan',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      initialRoute: RouteNames.splash,
      getPages: AppRouter.routes,
      defaultTransition: Transition.rightToLeftWithFade,
      transitionDuration: Duration(milliseconds: 300),
    );
  }
}
