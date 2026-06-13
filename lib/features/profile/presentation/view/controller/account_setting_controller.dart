import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/core/exceptions/app_exceptions.dart';
import 'package:reverse_mortage_loan_app/core/services/token_service.dart';
import 'package:reverse_mortage_loan_app/features/profile/domain/usecases/delete_account_usecase.dart';
import 'package:reverse_mortage_loan_app/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:reverse_mortage_loan_app/shared/dialoges/delete_account_dialog.dart';
import 'package:reverse_mortage_loan_app/shared/dialoges/logout_dialog.dart';

class AccountSettingController extends GetxController {
  final GetProfileUseCase _getProfileUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;
  final _logger = Logger();

  AccountSettingController({
    required GetProfileUseCase getProfileUseCase,
    required DeleteAccountUseCase deleteAccountUseCase,
  })  : _getProfileUseCase = getProfileUseCase,
        _deleteAccountUseCase = deleteAccountUseCase;

  void onEditProfile() {
    Get.toNamed(RouteNames.editProfile);
  }

  void onSetting() {
    Get.toNamed(RouteNames.setting);
  }

  void onLogout() {
    Get.dialog(
      LogoutDialog(
        onLogout: () async {
          await TokenService().deleteToken();
          Get.back();
          Get.offAllNamed(RouteNames.signIn);
        },
      ),
      barrierColor: Colors.white24,
    );
  }

  void onDeleteAccount() {
    Get.dialog(
      DeleteAccountDialog(
        onDelete: () async {
          Get.back();
          await _performDeleteAccount();
        },
      ),
      barrierColor: Colors.white24,
    );
  }

  Future<void> _performDeleteAccount() async {
    try {
      _logger.d('DeleteAccount — fetching profile to retrieve user id');
      final profile = await _getProfileUseCase();
      _logger.d('DeleteAccount — userId: ${profile.id}');

      await _deleteAccountUseCase(profile.id);
      _logger.i('DeleteAccount — account deleted successfully for userId: ${profile.id}');

      await TokenService().deleteToken();
      _logger.d('DeleteAccount — access token cleared');

      Get.offAllNamed(RouteNames.signIn);
    } on NoInternetException catch (e) {
      _logger.w('DeleteAccount — no internet: $e');
      Get.snackbar('No Internet', 'Check your connection and try again.');
    } on TimeoutException catch (e) {
      _logger.w('DeleteAccount — timeout: $e');
      Get.snackbar('Timeout', 'Server took too long. Please try again.');
    } on ServerException catch (e) {
      _logger.e('DeleteAccount — server error: $e');
      Get.snackbar('Error', e.message);
    } catch (e) {
      _logger.e('DeleteAccount — unexpected error: $e');
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    }
  }
}
