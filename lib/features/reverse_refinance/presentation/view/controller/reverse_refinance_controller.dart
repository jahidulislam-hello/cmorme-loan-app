import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';

class ReverseRefinanceController extends GetxController {
  final homeValueController = TextEditingController();
  final borrowerAgeController = TextEditingController();
  final firstBorrowerAgeController = TextEditingController();
  final secondBorrowerAgeController = TextEditingController();

  final isMultipleBorrower = false.obs;
  final photos = <File>[].obs;
  final currentPhotoIndex = 0.obs;

  final ImagePicker _picker = ImagePicker();

  String get loanType =>
      (Get.arguments as Map<String, dynamic>?)?['type'] ?? 'refinance';

  bool get isPurchase => loanType == 'purchase';

  String get screenTitle =>
      isPurchase ? 'Reverse for Purchase' : 'Reverse Refinance';

  void onBorrowerToggleChanged(bool isMultiple) {
    isMultipleBorrower.value = isMultiple;
  }

  void onPhotoPageChanged(int index) {
    currentPhotoIndex.value = index;
  }

  Future<void> onUploadPhotos() async {
    try {
      final remaining = 10 - photos.length;
      if (remaining <= 0) {
        Get.snackbar('Limit Reached', 'Maximum 10 photos allowed',
            snackPosition: SnackPosition.BOTTOM);
        return;
      }
      final pickedFiles = await _picker.pickMultiImage(
        imageQuality: 80,
        limit: remaining,
      );
      if (pickedFiles.isNotEmpty) {
        final files = pickedFiles
            .take(remaining)
            .map((xFile) => File(xFile.path))
            .toList();
        photos.addAll(files);
        currentPhotoIndex.value = 0;
      }
    } catch (e) {
      debugPrint('Image picker error: $e');
      Get.snackbar('Error', 'Unable to pick images. Please try again.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void onNext() {
    Get.toNamed(RouteNames.tipsCalculate, arguments: {'type': loanType});
  }

  @override
  void onClose() {
    homeValueController.dispose();
    borrowerAgeController.dispose();
    firstBorrowerAgeController.dispose();
    secondBorrowerAgeController.dispose();
    super.onClose();
  }
}
