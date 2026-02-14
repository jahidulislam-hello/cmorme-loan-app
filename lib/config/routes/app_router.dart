import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/features/authentication/presentation/view/binding/auth_binding.dart';
import 'package:reverse_mortage_loan_app/features/authentication/presentation/view/choose_account_screen.dart';
import 'package:reverse_mortage_loan_app/features/authentication/presentation/view/new_password_screen.dart';
import 'package:reverse_mortage_loan_app/features/authentication/presentation/view/otp_screen.dart';
import 'package:reverse_mortage_loan_app/features/authentication/presentation/view/sign_in_screen.dart';
import 'package:reverse_mortage_loan_app/features/authentication/presentation/view/sign_up_screen.dart';
import 'package:reverse_mortage_loan_app/features/authentication/presentation/view/verify_email_screen.dart';
import 'package:reverse_mortage_loan_app/features/home/presentation/view/splash_screen.dart';

class AppRouter {
  AppRouter._();

  static final routes = [
    GetPage(
      name: RouteNames.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: RouteNames.chooseAccount,
      page: () => const ChooseAccountScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: RouteNames.signIn,
      page: () => const SignInScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: RouteNames.signUp,
      page: () => const SignUpScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: RouteNames.verifyEmail,
      page: () => const VerifyEmailScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: RouteNames.otp,
      page: () => const OtpScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: RouteNames.newPassword,
      page: () => const NewPasswordScreen(),
      binding: AuthBinding(),
    ),
  ];
}
