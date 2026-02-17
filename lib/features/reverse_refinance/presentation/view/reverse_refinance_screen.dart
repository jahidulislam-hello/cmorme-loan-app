import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/shared/widgets/borrower_toggle.dart';
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),

                      /// Search bar (real estate only)
                      if (controller.isRealEstate) ...[
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.containerHighlight,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: controller.searchController,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 14,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Search by name or email',
                              hintStyle: TextStyle(
                                color: AppColors.hintGrey,
                                fontSize: 14,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: AppColors.hintGrey,
                                size: 24,
                              ),
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 14),
                            ),
                            cursorColor: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],

                      /// Form sections
                      if (controller.isRealEstate)
                        Obx(() => Column(
                              children: List.generate(
                                controller.formCount.value,
                                (index) => _buildFormSection(index),
                              ),
                            ))
                      else
                        _buildUserFormSection(),

                      /// Add button (real estate only)
                      if (controller.isRealEstate) ...[
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: CustomButton(
                            text: 'Add',
                            onPressed: controller.addFormSection,
                            width: 140,
                            backgroundColor: AppColors.green500,
                            textColor: AppColors.primary,
                            icon: Icons.add_box_outlined,
                          ),
                        ),
                      ],

                      const Spacer(),
                      const SizedBox(height: 24),

                      /// Bottom Button
                      CustomButton(
                        text: controller.isRealEstate
                            ? 'Calculate Loan'
                            : 'Next',
                        onPressed: controller.isRealEstate
                            ? controller.onCalculateLoan
                            : controller.onNext,
                        textColor: AppColors.primary,
                      ),

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

  /// User role: single form section (original layout)
  Widget _buildUserFormSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                if (controller.photos.isEmpty) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Center(
                      child: PhotoUploadSection(
                        photos: controller.photos,
                        currentPhotoIndex: controller.currentPhotoIndex.value,
                        onUploadTap: controller.onUploadPhotos,
                        onPageChanged: controller.onPhotoPageChanged,
                      ),
                    ),
                  );
                }
                return PhotoUploadSection(
                  photos: controller.photos,
                  currentPhotoIndex: controller.currentPhotoIndex.value,
                  onUploadTap: controller.onUploadPhotos,
                  onPageChanged: controller.onPhotoPageChanged,
                );
              }),
              const SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: LabeledInputField(
                  label: 'HOME VALUE',
                  hintText: '1500',
                  prefixIcon: Icons.attach_money,
                  controller: controller.homeValueController,
                  labelColor: AppColors.blue300,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        const Text(
          'AGE SET',
          style: TextStyle(
            color: AppColors.blue300,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        Obx(() => BorrowerToggle(
              isMultipleBorrower: controller.isMultipleBorrower.value,
              onChanged: controller.onBorrowerToggleChanged,
            )),

        const SizedBox(height: 20),

        Obx(() {
          if (controller.isMultipleBorrower.value) {
            return Row(
              children: [
                Expanded(
                  child: LabeledInputField(
                    label: '1st borrower age',
                    hintText: '75',
                    prefixImagePath: AppImages.borrowerIcon,
                    prefixIconColor: AppColors.buttonBlue,
                    controller: controller.firstBorrowerAgeController,
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
                    controller: controller.secondBorrowerAgeController,
                    labelColor: AppColors.hintGrey,
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
      ],
    );
  }

  /// Real estate role: indexed form section
  Widget _buildFormSection(int index) {
    return Padding(
      padding: EdgeInsets.only(bottom: index < controller.formCount.value - 1 ? 24 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Scenario label
          Text(
            'Scenario ${index + 1}',
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

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
                  final photos = controller.getPhotos(index);
                  final photoIndex = controller.getCurrentPhotoIndex(index);
                  if (photos.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 20, right: 20),
                      child: Center(
                        child: PhotoUploadSection(
                          photos: photos,
                          currentPhotoIndex: photoIndex.value,
                          onUploadTap: () =>
                              controller.onUploadPhotosAt(index),
                          onPageChanged: (i) =>
                              controller.onPhotoPageChangedAt(index, i),
                        ),
                      ),
                    );
                  }
                  return PhotoUploadSection(
                    photos: photos,
                    currentPhotoIndex: photoIndex.value,
                    onUploadTap: () => controller.onUploadPhotosAt(index),
                    onPageChanged: (i) =>
                        controller.onPhotoPageChangedAt(index, i),
                  );
                }),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 20),
                  child: LabeledInputField(
                    label: 'HOME VALUE',
                    hintText: '1500',
                    prefixIcon: Icons.attach_money,
                    controller: controller.getHomeValueController(index),
                    labelColor: AppColors.blue300,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'AGE SET',
            style: TextStyle(
              color: AppColors.blue300,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Obx(() => BorrowerToggle(
                isMultipleBorrower:
                    controller.getIsMultipleBorrower(index).value,
                onChanged: (isMultiple) =>
                    controller.onBorrowerToggleChangedAt(index, isMultiple),
              )),

          const SizedBox(height: 20),

          Obx(() {
            if (controller.getIsMultipleBorrower(index).value) {
              return Row(
                children: [
                  Expanded(
                    child: LabeledInputField(
                      label: '1st borrower age',
                      hintText: '75',
                      prefixImagePath: AppImages.borrowerIcon,
                      prefixIconColor: AppColors.buttonBlue,
                      controller:
                          controller.getFirstBorrowerAgeController(index),
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
                          controller.getSecondBorrowerAgeController(index),
                      labelColor: AppColors.hintGrey,
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
              controller: controller.getBorrowerAgeController(index),
              labelColor: AppColors.hintGrey,
            );
          }),
        ],
      ),
    );
  }
}
