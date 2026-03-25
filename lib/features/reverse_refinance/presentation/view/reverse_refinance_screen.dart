import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/shared/widgets/borrower_toggle.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_shimmer_loading_indicator.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/shared/widgets/labeled_input_field.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/shared/widgets/photo_upload_section.dart';
import 'package:reverse_mortage_loan_app/shared/app_image/app_images.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_button.dart';
import 'controller/reverse_refinance_controller.dart';

class ReverseRefinanceScreen extends GetView<ReverseRefinanceController> {
  const ReverseRefinanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.white),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(
          controller.screenTitle,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),

                      /// Photo Upload + Home Value Container
                      Container(
                        width: double.infinity,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: AppColors.containerHighlight,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() {
                              if (controller.isUploadingImages.value) {
                                return Column(
                                  children: [
                                    const PhotoUploadShimmer(),
                                    if (controller.uploadProgressText.value.isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8),
                                        child: Text(
                                          controller.uploadProgressText.value,
                                          style: const TextStyle(
                                            color: AppColors.hintGrey,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              }
                              if (controller.photos.isEmpty) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 20, right: 20),
                                  child: Center(
                                    child: PhotoUploadSection(
                                      photos: controller.photos,
                                      currentPhotoIndex:
                                          controller.currentPhotoIndex.value,
                                      onUploadTap: controller.onUploadPhotos,
                                      onPageChanged:
                                          controller.onPhotoPageChanged,
                                    ),
                                  ),
                                );
                              }
                              return PhotoUploadSection(
                                photos: controller.photos,
                                currentPhotoIndex:
                                    controller.currentPhotoIndex.value,
                                onUploadTap: controller.onUploadPhotos,
                                onPageChanged: controller.onPhotoPageChanged,
                              );
                            }),
                            const SizedBox(height: 20),
                            Obx(() => Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 20),
                              child: LabeledInputField(
                                label: 'HOME VALUE',
                              //  hintText: '1500',
                              //  prefixIcon: Icons.attach_money,
                                prefixImagePath: AppImages.dollarIcon,
                                controller: controller.homeValueController,
                                labelColor: AppColors.blue300,
                                errorText: controller.homeValueError.value,
                              ),
                            )),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),
                      if (!controller.isPurchase)
                      Obx(() => LabeledInputField(
                        label: 'Current Mortgage Balance',
                       // hintText: '1500',
                      //  prefixIcon: Icons.attach_money,
                        prefixImagePath: AppImages.dollarIcon,
                        controller: controller.mortgageBalanceController,
                        labelColor: AppColors.blue300,
                        errorText: controller.mortgageBalanceValueError.value,
                      )),
                      const SizedBox(height: 24),
                      const Text(
                        'AGE SET',
                        style: TextStyle(
                          color: AppColors.blue300,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Obx(() => BorrowerToggle(
                            isMultipleBorrower:
                                controller.isMultipleBorrower.value,
                            onChanged: controller.onBorrowerToggleChanged,
                          )),

                      const SizedBox(height: 20),

                      Obx(() {
                        if (controller.isMultipleBorrower.value) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: LabeledInputField(
                                      label: '1st borrower age',
                                      hintText: '75',
                                      prefixImagePath: AppImages.borrowerIcon,
                                      prefixIconColor: AppColors.buttonBlue,
                                      controller:
                                          controller.firstBorrowerAgeController,
                                      labelColor: AppColors.hintGrey,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: LabeledInputField(
                                      label: '2nd borrower age',
                                      hintText: '75',
                                      prefixImagePath: AppImages.borrowerIcon,
                                      prefixIconColor: AppColors.buttonBlue,
                                      controller:
                                          controller.secondBorrowerAgeController,
                                      labelColor: AppColors.hintGrey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              GestureDetector(
                                onTap: controller.onMarriedToggle,
                                behavior: HitTestBehavior.opaque,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Obx(() => Radio<bool>(
                                          value: true,
                                          groupValue: controller.isMarried.value
                                              ? true
                                              : null,
                                          toggleable: true,
                                          onChanged: (_) =>
                                              controller.onMarriedToggle(),
                                          activeColor: AppColors.buttonBlue,
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        )),
                                    const Text(
                                      'Married',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                        return LabeledInputField(
                          label: 'Borrower age',
                          hintText: '75',
                          prefixImagePath: AppImages.borrowerIcon,
                          prefixIconColor: AppColors.buttonBlue,
                          controller: controller.borrowerAgeController,
                          labelColor: AppColors.hintGrey,
                        );
                      }),

                      const Spacer(),
                      const SizedBox(height: 24),

                      /// Bottom Button
                      Obx(() => CustomButton(
                        text: 'Calculate Loan',
                        onPressed: controller.onNext,
                        textColor: AppColors.white,
                        isLoading: controller.isLoading.value,
                      )),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
