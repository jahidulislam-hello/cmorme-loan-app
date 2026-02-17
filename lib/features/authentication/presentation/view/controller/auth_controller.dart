import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';

class AuthController extends GetxController {
  // User role
  static final userRole = 'user'.obs;

  bool get isRealEstate => userRole.value == 'real_estate';

  // Text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final verifyEmailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final newConfirmPasswordController = TextEditingController();

  // OTP controllers and focus nodes
  late List<TextEditingController> otpControllers;
  late List<FocusNode> otpFocusNodes;

  // Observables
  final obscurePassword = true.obs;
  final obscureConfirmPassword = true.obs;
  final obscureNewPassword = true.obs;
  final obscureNewConfirmPassword = true.obs;

  @override
  void onInit() {
    super.onInit();
    otpControllers = List.generate(5, (_) => TextEditingController());
    otpFocusNodes = List.generate(5, (_) => FocusNode());
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    verifyEmailController.dispose();
    newPasswordController.dispose();
    newConfirmPasswordController.dispose();
    for (final c in otpControllers) {
      c.dispose();
    }
    for (final f in otpFocusNodes) {
      f.dispose();
    }
    super.onClose();
  }

  void togglePasswordVisibility() =>
      obscurePassword.value = !obscurePassword.value;

  void toggleConfirmPasswordVisibility() =>
      obscureConfirmPassword.value = !obscureConfirmPassword.value;

  void toggleNewPasswordVisibility() =>
      obscureNewPassword.value = !obscureNewPassword.value;

  void toggleNewConfirmPasswordVisibility() =>
      obscureNewConfirmPassword.value = !obscureNewConfirmPassword.value;

  // Navigation
  void goToSignIn() => Get.toNamed(RouteNames.signIn);
  void goToSignUp() => Get.toNamed(RouteNames.signUp);
  void goToVerifyEmail() => Get.toNamed(RouteNames.verifyEmail);
  void goToOtp() => Get.toNamed(RouteNames.otp);
  void goToNewPassword() => Get.toNamed(RouteNames.newPassword);
  void goToChooseAccount() => Get.toNamed(RouteNames.chooseAccount);

  // Actions
  void login() {
    // TODO: Implement login logic
    goToVerifyEmail();
  }

  void signUp() {
    // TODO: Implement sign up logic
    goToVerifyEmail();
  }

  void verifyEmail() {
    // TODO: Implement verify email logic
    goToOtp();
  }

  void verifyOtp() {
    // TODO: Implement OTP verification logic
    goToNewPassword();
  }

  void resetPassword() {
    // TODO: Implement reset password logic
    goToSignIn();
  }

  void chooseUserAccount() {
    userRole.value = 'user';
    goToSignIn();
  }

  void chooseRealStateAccount() {
    userRole.value = 'real_estate';
    goToSignIn();
  }
}
