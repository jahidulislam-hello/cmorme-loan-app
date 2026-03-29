import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/core/exceptions/app_exceptions.dart';
import 'package:reverse_mortage_loan_app/features/profile/data/models/change_password_request_model.dart';
import 'package:reverse_mortage_loan_app/features/profile/domain/usecases/change_password_usecase.dart';

class ChangePasswordController extends GetxController {
  final ChangePasswordUseCase _changePasswordUseCase;
  final _logger = Logger();

  ChangePasswordController({required ChangePasswordUseCase changePasswordUseCase})
      : _changePasswordUseCase = changePasswordUseCase;

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isLoading = false.obs;
  final obscureOldPassword = true.obs;
  final obscureNewPassword = true.obs;
  final obscureConfirmPassword = true.obs;

  final oldPasswordError = Rxn<String>();
  final newPasswordError = Rxn<String>();
  final confirmPasswordError = Rxn<String>();

  void toggleOldPasswordVisibility() =>
      obscureOldPassword.value = !obscureOldPassword.value;

  void toggleNewPasswordVisibility() =>
      obscureNewPassword.value = !obscureNewPassword.value;

  void toggleConfirmPasswordVisibility() =>
      obscureConfirmPassword.value = !obscureConfirmPassword.value;

  Future<void> onUpdate() async {
    oldPasswordError.value = oldPasswordController.text.trim().isEmpty ? 'Old password is required' : null;
    newPasswordError.value = newPasswordController.text.trim().isEmpty ? 'New password is required' : null;
    confirmPasswordError.value = confirmPasswordController.text.trim().isEmpty ? 'Confirm password is required' : null;

    if (oldPasswordError.value != null ||
        newPasswordError.value != null ||
        confirmPasswordError.value != null) return;

    isLoading.value = true;
    try {
      final request = ChangePasswordRequestModel(
        oldPassword: oldPasswordController.text,
        newPassword: newPasswordController.text,
        confirmPassword: confirmPasswordController.text,
      );
      final response = await _changePasswordUseCase(request);
      _logger.i('Change password success: ${response.message}');
      Get.offAllNamed(RouteNames.userHome);
    } on NoInternetException catch (e) {
      _logger.w('No internet during change password: $e');
      Get.snackbar('No Internet', e.message);
    } on TimeoutException catch (e) {
      _logger.w('Timeout during change password: $e');
      Get.snackbar('Timeout', 'Server took too long. Please try again.');
    } on ServerException catch (e) {
      _logger.e('Server error during change password: $e');
      Get.snackbar('Error', e.message);
    } catch (e) {
      _logger.e('Unknown error during change password: $e');
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
