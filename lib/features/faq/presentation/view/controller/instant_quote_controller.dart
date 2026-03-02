import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InstantQuoteController extends GetxController {
  final ageController = TextEditingController();
  final homeValueController = TextEditingController();
  final mortgageDeptController = TextEditingController();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final zipCodeController = TextEditingController();

  void onGetYourCode() {
    // TODO: integrate API submission
    Get.snackbar(
      'Success',
      'Your quote request has been submitted!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onClose() {
    ageController.dispose();
    homeValueController.dispose();
    mortgageDeptController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    zipCodeController.dispose();
    super.onClose();
  }
}
