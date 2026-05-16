import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/core/exceptions/app_exceptions.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/data/models/calculate_loan_request_model.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/domain/usecases/calculate_loan_usecase.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/domain/usecases/upload_file_usecase.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';


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
  final isMarried = false.obs;
  final photos = <File>[].obs;
  final currentPhotoIndex = 0.obs;
  final uploadedImagePaths = <String>[].obs;
  final isUploadingImages = false.obs;
  final uploadProgressText = ''.obs;
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
    if (!isMultiple) isMarried.value = false;
  }

  void onMarriedToggle() {
    _logger.d('onMarriedToggle called — before: ${isMarried.value}');
    isMarried.value = !isMarried.value;
    _logger.d('onMarriedToggle done — after: ${isMarried.value}');
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

      isUploadingImages.value = true;
      final List<(File, String)> successfulUploads = [];
      int failedCount = 0;
      bool noInternet = false;

      for (int i = 0; i < newFiles.length; i++) {
        uploadProgressText.value = 'Uploading ${i + 1} of ${newFiles.length}...';
        final file = await _prepareFile(newFiles[i]);
        try {
          final result = await _uploadFileUseCase(file);
          successfulUploads.add((file, result.path));
          _logger.i('Image uploaded: ${result.path}');
        } on NoInternetException catch (e) {
          _logger.w('No internet uploading image: $e');
          noInternet = true;
          break;
        } on ServerException catch (e) {
          _logger.e('Server error uploading image: $e');
          failedCount++;
        } catch (e) {
          _logger.e('Unknown error uploading image ${file.path}: $e');
          failedCount++;
        }
      }

      if (successfulUploads.isNotEmpty) {
        photos.addAll(successfulUploads.map((u) => u.$1));
        uploadedImagePaths.addAll(successfulUploads.map((u) => u.$2));
        currentPhotoIndex.value = 0;
      }

      // One summary snackbar — not one per failed image
      if (noInternet) {
        Get.snackbar('No Internet', 'Check your connection and try again.',
            snackPosition: SnackPosition.BOTTOM);
      } else if (failedCount > 0) {
        Get.snackbar(
          'Upload Failed',
          '$failedCount image${failedCount > 1 ? 's' : ''} failed to upload.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      _logger.e('Image picker error: $e');
      Get.snackbar('Error', 'Unable to pick images. Please try again.',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      uploadProgressText.value = '';
      isUploadingImages.value = false;
    }
  }


  Future<File> _prepareFile(File file) async {
    final isPng = file.path.toLowerCase().endsWith('.png');
    if (!isPng) return file;

    try {
      final tempDir = await getTemporaryDirectory();
      final targetPath =
          '${tempDir.path}/resized_${DateTime.now().millisecondsSinceEpoch}.jpg';

      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        format: CompressFormat.jpeg,
        quality: 85,
        minWidth: 1280,
        minHeight: 1,
      );

      if (result == null) return file;

      _logger.d('PNG compressed to JPEG: ${file.path} → ${result.path}');
      return File(result.path);
    } catch (e) {
      _logger.w('PNG compress failed, using original: $e');
      return file;
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
    if (!isPurchase && mortgageBalanceController.text.trim().isEmpty) {
      mortgageBalanceValueError.value = 'Please enter mortgage balance.';
      hasError = true;
    } else {
      mortgageBalanceValueError.value = null;
    }
    if (hasError) return;


    if (isMultipleBorrower.value) {
      final age1 = int.tryParse(firstBorrowerAgeController.text.trim());
      final age2 = int.tryParse(secondBorrowerAgeController.text.trim());


      if (age1 != null && age2 != null && age1 < 55 && age2 < 55) {
        await Get.dialog(
          AlertDialog(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            title: const Text(
              'Age Requirement',
              style: TextStyle(
                  color: AppColors.white, fontWeight: FontWeight.bold),
            ),
            content: const Text(
              'For a Non-Government Reverse Mortgage, at least one borrower must be 55 years or older.',
              style: TextStyle(
                  color: AppColors.hintGrey, fontSize: 14, height: 1.5),
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('OK',
                    style: TextStyle(color: AppColors.green500)),
              ),
            ],
          ),
        );
        return;
      }

      // Married confirmation popup if married box not checked
      if (!isMarried.value) {
        final confirmed = await Get.dialog<bool>(
          AlertDialog(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            content: const Text(
             // 'You did not check if both borrowers are married. If this is not true, please go back and check "Married". Otherwise, please confirm to resume calculation.',
              'If borrowers are married to each other, then please press "Go Back" and check "Married". Otherwise please press Confirm.',
              style: TextStyle(
                  color: AppColors.hintGrey, fontSize: 14, height: 1.5),
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(result: false),
                child: const Text('Go Back',
                    style: TextStyle(color: AppColors.hintGrey)),
              ),
              TextButton(
                onPressed: () => Get.back(result: true),
                child: const Text('Confirm',
                    style: TextStyle(color: AppColors.green500)),
              ),
            ],
          ),
        );
        if (confirmed != true) return;
      }
    }


    final request = CalculateLoanRequestModel(
      financeType: financeType,
      homeValue: double.parse(homeValueController.text.trim()),
      homeImg: uploadedImagePaths.toList(),
      mortgageAmount: double.tryParse(mortgageBalanceController.text.trim()),
      singleBorrowerAge: isMultipleBorrower.value
          ? null
          : int.tryParse(borrowerAgeController.text.trim()),
      isMarried: isMultipleBorrower.value ? isMarried.value : null,
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
