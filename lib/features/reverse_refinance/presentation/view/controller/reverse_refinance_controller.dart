import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/core/exceptions/app_exceptions.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/data/models/calculate_loan_request_model.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/domain/usecases/calculate_loan_usecase.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/domain/usecases/upload_file_usecase.dart';

class ReverseRefinanceController extends GetxController {
  final UploadFileUseCase _uploadFileUseCase;
  final CalculateLoanUseCase _calculateLoanUseCase;
  final _logger = Logger();

  ReverseRefinanceController({
    required UploadFileUseCase uploadFileUseCase,
    required CalculateLoanUseCase calculateLoanUseCase,
  })  : _uploadFileUseCase = uploadFileUseCase,
        _calculateLoanUseCase = calculateLoanUseCase;

  final homeValueController = TextEditingController();
  final loanBalanceController = TextEditingController();
  final borrowerAgeController = TextEditingController();
  final firstBorrowerAgeController = TextEditingController();
  final secondBorrowerAgeController = TextEditingController();

  final isMultipleBorrower = false.obs;
  final photos = <File>[].obs;
  final currentPhotoIndex = 0.obs;
  final uploadedImagePaths = <String>[].obs;
  final isUploadingImages = false.obs;
  final isLoading = false.obs;

  final ImagePicker _picker = ImagePicker();

  String get loanType =>
      (Get.arguments as Map<String, dynamic>?)?['type'] ?? 'refinance';

  bool get isPurchase => loanType == 'purchase';

  String get financeType =>
      isPurchase ? 'peverse_purchase' : 'reverse_refinance';

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
      if (pickedFiles.isEmpty) return;

      final newFiles = pickedFiles.take(remaining).map((x) => File(x.path)).toList();
      photos.addAll(newFiles);
      currentPhotoIndex.value = 0;

      // Upload each picked image immediately
      isUploadingImages.value = true;
      for (final file in newFiles) {
        try {
          final result = await _uploadFileUseCase(file);
          uploadedImagePaths.add(result.path);
          _logger.i('Image uploaded: ${result.path}');
        } catch (e) {
          _logger.e('Failed to upload image ${file.path}: $e');
          Get.snackbar('Upload Error', 'Failed to upload one or more images. Please try again.',
              snackPosition: SnackPosition.BOTTOM);
        }
      }
    } catch (e) {
      _logger.e('Image picker error: $e');
      Get.snackbar('Error', 'Unable to pick images. Please try again.',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isUploadingImages.value = false;
    }
  }

  Future<void> onNext() async {
    if (uploadedImagePaths.isEmpty) {
      Get.snackbar('Required', 'Please upload at least one photo.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (homeValueController.text.trim().isEmpty) {
      Get.snackbar('Required', 'Please enter home value.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (loanBalanceController.text.trim().isEmpty) {
      Get.snackbar('Required', 'Please enter current loan balance.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final request = CalculateLoanRequestModel(
      financeType: financeType,
      homeImg: uploadedImagePaths.toList(),
      homeValue: double.parse(homeValueController.text.trim()),
      mortgageAmount: double.parse(loanBalanceController.text.trim()),
      singleBorrowerAge: isMultipleBorrower.value
          ? null
          : int.tryParse(borrowerAgeController.text.trim()),
      multipleBorrowerAge1: isMultipleBorrower.value
          ? int.tryParse(firstBorrowerAgeController.text.trim())
          : null,
      multipleBorrowerAge2: isMultipleBorrower.value
          ? int.tryParse(secondBorrowerAgeController.text.trim())
          : null,
    );

    Get.toNamed(RouteNames.tipsCalculate, arguments: {
      'type': loanType,
      'request': request,
    });
  }

  @override
  void onClose() {
    homeValueController.dispose();
    loanBalanceController.dispose();
    borrowerAgeController.dispose();
    firstBorrowerAgeController.dispose();
    secondBorrowerAgeController.dispose();
    super.onClose();
  }
}
