import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/core/exceptions/app_exceptions.dart';
import 'package:reverse_mortage_loan_app/features/profile/data/models/update_profile_request_model.dart';
import 'package:reverse_mortage_loan_app/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:reverse_mortage_loan_app/features/profile/domain/usecases/update_profile_usecase.dart';

class EditProfileController extends GetxController {
  final GetProfileUseCase _getProfileUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final _logger = Logger();

  EditProfileController({
    required GetProfileUseCase getProfileUseCase,
    required UpdateProfileUseCase updateProfileUseCase,
  })  : _getProfileUseCase = getProfileUseCase,
        _updateProfileUseCase = updateProfileUseCase;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    try {
      final profile = await _getProfileUseCase();
      firstNameController.text = profile.firstName;
      lastNameController.text = profile.lastName ?? '';
      _logger.i('EditProfile prefilled: ${profile.firstName}');
    } on NoInternetException catch (e) {
      _logger.w('No internet fetching profile: $e');
      Get.snackbar('No Internet', e.message);
    } on ServerException catch (e) {
      _logger.e('Server error fetching profile: $e');
      Get.snackbar('Error', e.message);
    } catch (e) {
      _logger.e('Unknown error fetching profile: $e');
    }
  }

  Future<void> onUpdate() async {
    isLoading.value = true;
    try {
      final request = UpdateProfileRequestModel(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
      );
      final response = await _updateProfileUseCase(request);
      _logger.i('Profile updated: ${response.message}');
     // Get.snackbar('Success', response.message);
      Get.offAllNamed(RouteNames.userHome);
    } on NoInternetException catch (e) {
      _logger.w('No internet during update: $e');
      Get.snackbar('No Internet', e.message);
    } on TimeoutException catch (e) {
      _logger.w('Timeout during update: $e');
      Get.snackbar('Timeout', 'Server took too long. Please try again.');
    } on ServerException catch (e) {
      _logger.e('Server error during update: $e');
      Get.snackbar('Error', e.message);
    } catch (e) {
      _logger.e('Unknown error during update: $e');
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.onClose();
  }
}
