import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/features/authentication/presentation/view/controller/auth_controller.dart';

class ReverseRefinanceController extends GetxController {
  // Single-form controllers (used for "user" role, maps to index 0 for real estate)
  final homeValueController = TextEditingController();
  final borrowerAgeController = TextEditingController();
  final firstBorrowerAgeController = TextEditingController();
  final secondBorrowerAgeController = TextEditingController();

  final isMultipleBorrower = false.obs;
  final photos = <File>[].obs;
  final currentPhotoIndex = 0.obs;

  // Real estate multi-form state
  final searchController = TextEditingController();
  final formCount = 1.obs;
  final homeValueControllers = <TextEditingController>[].obs;
  final borrowerAgeControllers = <TextEditingController>[].obs;
  final firstBorrowerAgeControllers = <TextEditingController>[].obs;
  final secondBorrowerAgeControllers = <TextEditingController>[].obs;
  final isMultipleBorrowerList = <RxBool>[].obs;
  final photosList = <RxList<File>>[].obs;
  final currentPhotoIndexList = <RxInt>[].obs;

  final ImagePicker _picker = ImagePicker();

  bool get isRealEstate => AuthController.userRole.value == 'real_estate';

  String get loanType =>
      (Get.arguments as Map<String, dynamic>?)?['type'] ?? 'refinance';

  bool get isPurchase => loanType == 'purchase';

  String get screenTitle =>
      isPurchase ? 'Reverse for Purchase' : 'Reverse Refinance';

  @override
  void onInit() {
    super.onInit();
    if (isRealEstate) {
      _addFormControllers();
    }
  }

  void _addFormControllers() {
    homeValueControllers.add(TextEditingController());
    borrowerAgeControllers.add(TextEditingController());
    firstBorrowerAgeControllers.add(TextEditingController());
    secondBorrowerAgeControllers.add(TextEditingController());
    isMultipleBorrowerList.add(false.obs);
    photosList.add(<File>[].obs);
    currentPhotoIndexList.add(0.obs);
  }

  void addFormSection() {
    _addFormControllers();
    formCount.value = homeValueControllers.length;
  }

  // Real estate form accessors
  TextEditingController getHomeValueController(int index) =>
      homeValueControllers[index];

  TextEditingController getBorrowerAgeController(int index) =>
      borrowerAgeControllers[index];

  TextEditingController getFirstBorrowerAgeController(int index) =>
      firstBorrowerAgeControllers[index];

  TextEditingController getSecondBorrowerAgeController(int index) =>
      secondBorrowerAgeControllers[index];

  RxBool getIsMultipleBorrower(int index) => isMultipleBorrowerList[index];

  RxList<File> getPhotos(int index) => photosList[index];

  RxInt getCurrentPhotoIndex(int index) => currentPhotoIndexList[index];

  void onBorrowerToggleChangedAt(int index, bool isMultiple) {
    isMultipleBorrowerList[index].value = isMultiple;
  }

  void onPhotoPageChangedAt(int index, int photoIndex) {
    currentPhotoIndexList[index].value = photoIndex;
  }

  Future<void> onUploadPhotosAt(int index) async {
    try {
      final photos = photosList[index];
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
        currentPhotoIndexList[index].value = 0;
      }
    } catch (e) {
      debugPrint('Image picker error: $e');
      Get.snackbar('Error', 'Unable to pick images. Please try again.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Single-form methods (user role)
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

  void onCalculateLoan() {
    Get.toNamed(RouteNames.tipsCalculate, arguments: {'type': loanType});
  }

  @override
  void onClose() {
    homeValueController.dispose();
    borrowerAgeController.dispose();
    firstBorrowerAgeController.dispose();
    secondBorrowerAgeController.dispose();
    searchController.dispose();
    for (final c in homeValueControllers) {
      c.dispose();
    }
    for (final c in borrowerAgeControllers) {
      c.dispose();
    }
    for (final c in firstBorrowerAgeControllers) {
      c.dispose();
    }
    for (final c in secondBorrowerAgeControllers) {
      c.dispose();
    }
    super.onClose();
  }
}
