import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/core/exceptions/app_exceptions.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/forget_password_request_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/login_request_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/register_request_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/reset_password_request_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/verify_otp_request_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/domain/usecases/forget_password_usecase.dart';
import 'package:reverse_mortage_loan_app/features/authentication/domain/usecases/login_usecase.dart';
import 'package:reverse_mortage_loan_app/features/authentication/domain/usecases/register_usecase.dart';
import 'package:reverse_mortage_loan_app/features/authentication/domain/usecases/reset_password_usecase.dart';
import 'package:reverse_mortage_loan_app/features/authentication/domain/usecases/resend_otp_usecase.dart';
import 'package:reverse_mortage_loan_app/features/authentication/domain/usecases/verify_forget_otp_usecase.dart';
import 'package:reverse_mortage_loan_app/features/authentication/domain/usecases/verify_otp_usecase.dart';

enum OtpFlow { registration, forgotPassword }

class AuthController extends GetxController {
  final RegisterUseCase _registerUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;
  final LoginUseCase _loginUseCase;
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final VerifyForgetOtpUseCase _verifyForgetOtpUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final ResendOtpUseCase _resendOtpUseCase;
  final _logger = Logger();

  AuthController({
    required RegisterUseCase registerUseCase,
    required VerifyOtpUseCase verifyOtpUseCase,
    required LoginUseCase loginUseCase,
    required ForgetPasswordUseCase forgetPasswordUseCase,
    required VerifyForgetOtpUseCase verifyForgetOtpUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
    required ResendOtpUseCase resendOtpUseCase,
  })  : _registerUseCase = registerUseCase,
        _verifyOtpUseCase = verifyOtpUseCase,
        _loginUseCase = loginUseCase,
        _forgetPasswordUseCase = forgetPasswordUseCase,
        _verifyForgetOtpUseCase = verifyForgetOtpUseCase,
        _resetPasswordUseCase = resetPasswordUseCase,
        _resendOtpUseCase = resendOtpUseCase;

  // User role
  static final userRole = 'user'.obs;
  bool get isRealEstate => userRole.value == 'real_estate';

  // OTP flow tracker
  final otpFlow = OtpFlow.registration.obs;

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
  final isLoading = false.obs;
  final obscurePassword = true.obs;
  final obscureConfirmPassword = true.obs;
  final obscureNewPassword = true.obs;
  final obscureNewConfirmPassword = true.obs;

  @override
  void onInit() {
    super.onInit();
    otpControllers = List.generate(6, (_) => TextEditingController());
    otpFocusNodes = List.generate(6, (_) => FocusNode());
  }

  @override
  void onClose() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    firstNameController.clear();
    lastNameController.clear();
    verifyEmailController.clear();
    newPasswordController.clear();
    newConfirmPasswordController.clear();
    for (final c in otpControllers) {
      c.clear();
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

  // ─── Login ───────────────────────────────────────────────────────────────

  Future<void> login() async {
    isLoading.value = true;
    try {
      final request = LoginRequestModel(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      final response = await _loginUseCase(request);
      _logger.i('Login success: ${response.message}');
      Get.offAllNamed(RouteNames.userHome);
    } on NoInternetException catch (e) {
      _logger.w('No internet during login: $e');
      Get.snackbar('No Internet', e.message);
    } on TimeoutException catch (e) {
      _logger.w('Timeout during login: $e');
      Get.snackbar('Timeout', 'Server took too long. Please try again.');
    } on ServerException catch (e) {
      _logger.e('Server error during login: $e');
      Get.snackbar('Error', e.message);
    } catch (e) {
      _logger.e('Unknown error during login: $e');
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  // ─── Register ─────────────────────────────────────────────────────────────

  Future<void> signUp() async {
    isLoading.value = true;
    try {
      final request = RegisterRequestModel(
        firstName: firstNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
      );
      final response = await _registerUseCase(request);
      _logger.i('Register success: ${response.message}');
      otpFlow.value = OtpFlow.registration;
      goToOtp();
    } on NoInternetException catch (e) {
      _logger.w('No internet during register: $e');
      Get.snackbar('No Internet', e.message);
    } on TimeoutException catch (e) {
      _logger.w('Timeout during register: $e');
      Get.snackbar('Timeout', 'Server took too long. Please try again.');
    } on ServerException catch (e) {
      _logger.e('Server error during register: $e');
      Get.snackbar('Error', e.message);
    } catch (e) {
      _logger.e('Unknown error during register: $e');
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  // ─── Forget Password ──────────────────────────────────────────────────────

  Future<void> verifyEmail() async {
    isLoading.value = true;
    try {
      final request = ForgetPasswordRequestModel(
        email: verifyEmailController.text.trim(),
      );
      final response = await _forgetPasswordUseCase(request);
      _logger.i('Forget password success: ${response.message}');
      otpFlow.value = OtpFlow.forgotPassword;
      goToOtp();
    } on NoInternetException catch (e) {
      _logger.w('No internet during forget password: $e');
      Get.snackbar('No Internet', e.message);
    } on TimeoutException catch (e) {
      _logger.w('Timeout during forget password: $e');
      Get.snackbar('Timeout', 'Server took too long. Please try again.');
    } on ServerException catch (e) {
      _logger.e('Server error during forget password: $e');
      Get.snackbar('Error', e.message);
    } catch (e) {
      _logger.e('Unknown error during forget password: $e');
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  // ─── Resend OTP ───────────────────────────────────────────────────────────

  /// Email used for resend — matches whichever flow sent the OTP originally.
  String get _resendEmail => otpFlow.value == OtpFlow.registration
      ? emailController.text.trim()
      : verifyEmailController.text.trim();

  Future<void> resendOtp() async {
    isLoading.value = true;
    try {
      final response = await _resendOtpUseCase(_resendEmail);
      _logger.i('OTP resent: ${response.message}');
      Get.snackbar('OTP Sent', response.message,
          snackPosition: SnackPosition.BOTTOM);
    } on NoInternetException catch (e) {
      _logger.w('No internet during resend OTP: $e');
      Get.snackbar('No Internet', e.message);
    } on TimeoutException catch (e) {
      _logger.w('Timeout during resend OTP: $e');
      Get.snackbar('Timeout', 'Server took too long. Please try again.');
    } on ServerException catch (e) {
      _logger.e('Server error during resend OTP: $e');
      Get.snackbar('Error', e.message);
    } catch (e) {
      _logger.e('Unknown error during resend OTP: $e');
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  // ─── OTP Verification (shared screen, flow-aware) ─────────────────────────

  Future<void> verifyOtp() async {
    isLoading.value = true;
    try {
      final otp = otpControllers.map((c) => c.text).join();
      final request = VerifyOtpRequestModel(otp: otp);

      if (otpFlow.value == OtpFlow.registration) {
        final response = await _verifyOtpUseCase(request);
        _logger.i('OTP verified (registration): ${response.message}');
        Get.offAllNamed(RouteNames.signIn);
      } else {
        final response = await _verifyForgetOtpUseCase(request);
        _logger.i('OTP verified (forgot password): ${response.message}');
        goToNewPassword();
      }
    } on NoInternetException catch (e) {
      _logger.w('No internet during OTP verify: $e');
      Get.snackbar('No Internet', e.message);
    } on TimeoutException catch (e) {
      _logger.w('Timeout during OTP verify: $e');
      Get.snackbar('Timeout', 'Server took too long. Please try again.');
    } on ServerException catch (e) {
      _logger.e('Server error during OTP verify: $e');
      Get.snackbar('Error', e.message);
    } catch (e) {
      _logger.e('Unknown error during OTP verify: $e');
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  // ─── Reset Password ───────────────────────────────────────────────────────

  Future<void> resetPassword() async {
    isLoading.value = true;
    try {
      final request = ResetPasswordRequestModel(
        password: newPasswordController.text,
        confirmPassword: newConfirmPasswordController.text,
      );
      final response = await _resetPasswordUseCase(request);
      _logger.i('Password reset success: ${response.message}');
      Get.offAllNamed(RouteNames.signIn);
    } on NoInternetException catch (e) {
      _logger.w('No internet during reset password: $e');
      Get.snackbar('No Internet', e.message);
    } on TimeoutException catch (e) {
      _logger.w('Timeout during reset password: $e');
      Get.snackbar('Timeout', 'Server took too long. Please try again.');
    } on ServerException catch (e) {
      _logger.e('Server error during reset password: $e');
      Get.snackbar('Error', e.message);
    } catch (e) {
      _logger.e('Unknown error during reset password: $e');
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
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
