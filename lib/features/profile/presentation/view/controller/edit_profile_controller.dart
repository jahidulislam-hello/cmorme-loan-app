import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  void onUpdate() {
    // Handle profile update
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.onClose();
  }
}
