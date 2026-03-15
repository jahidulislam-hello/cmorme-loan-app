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
  final mortgageBalanceController = TextEditingController();
  final borrowerAgeController = TextEditingController();
  final firstBorrowerAgeController = TextEditingController();
  final secondBorrowerAgeController = TextEditingController();

  final isMultipleBorrower = false.obs;
  final photos = <File>[].obs;
  final currentPhotoIndex = 0.obs;
  final uploadedImagePaths = <String>[].obs;
  final isUploadingImages = false.obs;
  final isLoading = false.obs;
  final homeValueError = RxnString();
  final mortgageBalanceValueError = RxnString();

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    homeValueController.addListener(() {
      if (homeValueController.text.trim().isNotEmpty) {
        homeValueError.value = null;
      }
    });
    mortgageBalanceController.addListener(() {
      if (mortgageBalanceController.text.trim().isNotEmpty) {
        mortgageBalanceValueError.value = null;
      }
    });
  }

  String get loanType =>
      (Get.arguments as Map<String, dynamic>?)?['type'] ?? 'refinance';

  bool get isPurchase => loanType == 'purchase';

  String get financeType =>
      isPurchase ? 'reverse_purchase' : 'reverse_refinance';

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

      // Show loading overlay over the photo container; add photos only after upload succeeds
      isUploadingImages.value = true;
      final List<(File, String)> successfulUploads = [];
      for (final file in newFiles) {
        try {
          final result = await _uploadFileUseCase(file);
          successfulUploads.add((file, result.path));
          _logger.i('Image uploaded: ${result.path}');
        } catch (e) {
          _logger.e('Failed to upload image ${file.path}: $e');
          Get.snackbar('Upload Error', 'Failed to upload one or more images. Please try again.',
              snackPosition: SnackPosition.BOTTOM);
        }
      }
      if (successfulUploads.isNotEmpty) {
        photos.addAll(successfulUploads.map((u) => u.$1));
        uploadedImagePaths.addAll(successfulUploads.map((u) => u.$2));
        currentPhotoIndex.value = 0;
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
    bool hasError = false;
    if (homeValueController.text.trim().isEmpty) {
      homeValueError.value = 'Please enter home value.';
      hasError = true;
    } else {
      homeValueError.value = null;
    }
    if ( !isPurchase && mortgageBalanceController.text.trim().isEmpty) {
      mortgageBalanceValueError.value = 'Please enter mortgage balance.';
      hasError = true;
    } else {
      mortgageBalanceValueError.value = null;
    }
    if (hasError) return;


    final request = CalculateLoanRequestModel(
      financeType: financeType,
      homeValue: double.parse(homeValueController.text.trim()),
      homeImg: uploadedImagePaths.toList(),
      mortgageAmount: double.tryParse(mortgageBalanceController.text.trim()),
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
    mortgageBalanceController.dispose();
    borrowerAgeController.dispose();
    firstBorrowerAgeController.dispose();
    secondBorrowerAgeController.dispose();
    super.onClose();
  }
}
