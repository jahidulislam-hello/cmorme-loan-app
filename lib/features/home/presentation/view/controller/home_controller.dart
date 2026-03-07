import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/core/exceptions/app_exceptions.dart';
import 'package:reverse_mortage_loan_app/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:reverse_mortage_loan_app/shared/dialoges/delete_confirmation_dialog.dart';
import 'package:reverse_mortage_loan_app/shared/dialoges/delete_success_dialog.dart';

class HomeController extends GetxController {
  final GetProfileUseCase _getProfileUseCase;
  final _logger = Logger();

  HomeController({required GetProfileUseCase getProfileUseCase})
      : _getProfileUseCase = getProfileUseCase;

  final userName = ''.obs;
  final isProfileLoading = true.obs;
  final selectedNavIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    isProfileLoading.value = true;
    try {
      final profile = await _getProfileUseCase();
      userName.value = profile.firstName;
      _logger.i('Profile fetched: ${profile.firstName}');
    } on NoInternetException catch (e) {
      _logger.w('No internet fetching profile: $e');
    } on ServerException catch (e) {
      _logger.e('Server error fetching profile: $e');
    } catch (e) {
      _logger.e('Unknown error fetching profile: $e');
    } finally {
      isProfileLoading.value = false;
    }
  }

  void onNavTap(int index) {
    selectedNavIndex.value = index;
    if (index == 1) {
      Get.toNamed(RouteNames.history);
      selectedNavIndex.value = 0;
    } else if (index == 2) {
      Get.toNamed(RouteNames.accountSetting);
      selectedNavIndex.value = 0;
    }
  }

  void onNotification() {
    Get.toNamed(RouteNames.notification);
  }

  void onReverseRefinance() {
    Get.toNamed(RouteNames.reverseRefinance, arguments: {'type': 'refinance'});
  }

  void onReverseForPurchase() {
    Get.toNamed(RouteNames.reverseRefinance, arguments: {'type': 'purchase'});
  }

  void onReverseMortgageFAQ() {
    Get.toNamed(RouteNames.faq);
  }

  void onSeeAllCalculations() {
    Get.toNamed(RouteNames.recentCalculation);
  }

  void onViewDetails() {
    Get.toNamed(RouteNames.loanDetails);
  }

  void onDeleteCalculation() {
    Get.dialog(
      DeleteConfirmationDialog(
        onDelete: () {
          Get.back();
          Get.dialog(
            const DeleteSuccessDialog(),
            barrierColor: Colors.white24,
          );
        },
      ),
      barrierColor: Colors.white24,
    );
  }
}
