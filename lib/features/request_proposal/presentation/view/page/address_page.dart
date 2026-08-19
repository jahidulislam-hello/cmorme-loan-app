import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_button.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_text_field.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/presentation/view/controller/request_proposal_controller.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/consent_disclaimer.dart';

class AddressPage extends GetView<RequestProposalController> {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.chevron_left, color: AppColors.white, size: 30),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: const Text(
          'Request Full Proposal',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() => CustomTextField(
                                  label: 'Street Number & Name',
                                  hintText: 'Street Number & Name',
                                  labelColor: AppColors.blue200,
                                  controller: controller.addressController,
                                  filled: true,
                                  backgroundColor: AppColors.containerHighlight,
                                  errorText: controller.addressError.value,
                                  onChanged: (_) =>
                                      controller.addressError.value = null,
                                )),
                            const SizedBox(height: 30),
                            Obx(() => CustomTextField(
                              label: 'City',
                              hintText: 'City Name',
                              labelColor: AppColors.blue200,
                              controller: controller.cityController,
                              filled: true,
                              backgroundColor: AppColors.containerHighlight,
                              errorText: controller.cityError.value,
                              onChanged: (_) =>
                              controller.cityError.value = null,
                            )),
                            const SizedBox(height: 20),
                            Obx(() => CustomTextField(
                              label: 'State Code',
                              hintText: 'Code',
                              labelColor: AppColors.blue200,
                              controller: controller.stateCodeController,
                              filled: true,
                              backgroundColor: AppColors.containerHighlight,
                              errorText: controller.stateCodeError.value,
                              onChanged: (_) =>
                              controller.stateCodeError.value = null,
                            )),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                      const ConsentDisclaimer(),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: CustomButton(
                          text: 'Next',
                          onPressed: controller.goToPhonePage,
                          backgroundColor: AppColors.buttonBlue,
                          textColor: AppColors.white,
                        ),
                      ),
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
