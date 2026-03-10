import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_button.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/presentation/view/controller/request_proposal_controller.dart';

class PhonePage extends GetView<RequestProposalController> {
  const PhonePage({super.key});

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Phone No.',
                        style: const TextStyle(
                          color: AppColors.blue200,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 6),
                      IntlPhoneField(
                        controller: controller.phoneController,
                        initialCountryCode: 'US',
                        keyboardType: TextInputType.phone,
                        cursorColor: AppColors.white,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 14,
                        ),
                        dropdownTextStyle: const TextStyle(
                          color: AppColors.white,
                          fontSize: 14,
                        ),
                        dropdownIcon: const Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.hintGrey,
                        ),
                        dropdownDecoration: BoxDecoration(
                          color: AppColors.containerHighlight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Phone No.',
                          hintStyle: const TextStyle(
                            color: AppColors.hintGrey,
                            fontSize: 14,
                          ),
                          filled: true,
                          fillColor: AppColors.containerHighlight,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (phone) {
                          controller.phoneCompleteNumber = phone.completeNumber;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CustomButton(
                  text: 'Next',
                  onPressed: controller.goToInterested,
                  backgroundColor: AppColors.buttonBlue,
                  textColor: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
