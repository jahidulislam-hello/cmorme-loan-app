import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';

class RequestProposalController extends GetxController {
  final currentStep = 0.obs;
  late final PageController pageController;

  // Step 1 - Basic Information
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateCodeController = TextEditingController();

  // Step 2 - Interested
  final selectedInterest = 0.obs;
  final interestOptions = [
    'Reverse Mortgage - Reverse finance',
    'Reverse Mortgage - Reverse for purchase',
    'Reverse Mortgage - General Information',
  ];

  // Step 3 - Details for Loan Amount
  final homeValueController = TextEditingController();
  final dobController = TextEditingController();

  // Step 4 - Inquiry
  final inquiryController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  void goToStep(int step) {
    currentStep.value = step;
    pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void nextStep() {
    if (currentStep.value < 3) {
      currentStep.value++;
      pageController.animateToPage(
        currentStep.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void onSend() {
    Get.toNamed(RouteNames.inquirySuccess);
  }

  @override
  void onClose() {
    pageController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateCodeController.dispose();
    homeValueController.dispose();
    dobController.dispose();
    inquiryController.dispose();
    super.onClose();
  }
}
