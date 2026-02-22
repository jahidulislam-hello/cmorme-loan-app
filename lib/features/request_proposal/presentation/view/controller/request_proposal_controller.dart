import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';

class RequestProposalController extends GetxController {
  final currentStep = 0.obs;

  // Step 1 - Basic Information
  final fullNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();

  // Step 2 - Address
  final addressController = TextEditingController();

  // Step 3 - City & State
  final cityController = TextEditingController();
  final stateCodeController = TextEditingController();

  // Step 4 - Interested
  final selectedInterest = 0.obs;
  final interestOptions = [
    'Reverse Mortgage - Reverse Refinance',
    'Reverse Mortgage - Reverse for purchase',
  ];

  // Step 5 - Details for Loan Amount
  final homeValueController = TextEditingController();

  // Step 6 - Date of Birth
  final dobController = TextEditingController();

  // Step 7 - Inquiry
  final inquiryController = TextEditingController();

  // Step 8 - Appointment
  final selectedDate = Rxn<DateTime>();
  final timeController = TextEditingController();

  void goToAddress() {
    Get.toNamed(RouteNames.proposalAddress);
  }

  void goToCityState() {
    Get.toNamed(RouteNames.proposalCityState);
  }

  void goToInterested() {
    Get.toNamed(RouteNames.proposalInterested);
  }

  void goToLoanAmount() {
    Get.toNamed(RouteNames.proposalLoanAmount);
  }

  void goToDob() {
    Get.toNamed(RouteNames.proposalDob);
  }

  void goToInquiry() {
    Get.toNamed(RouteNames.proposalInquiry);
  }

  void goToAppointment() {
    Get.toNamed(RouteNames.proposalAppointment);
  }

  void onSend() {
    Get.toNamed(RouteNames.inquirySuccess);
  }

  @override
  void onClose() {
    fullNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateCodeController.dispose();
    homeValueController.dispose();
    dobController.dispose();
    inquiryController.dispose();
    timeController.dispose();
    super.onClose();
  }
}
