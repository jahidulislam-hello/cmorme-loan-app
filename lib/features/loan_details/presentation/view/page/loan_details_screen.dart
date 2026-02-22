import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_button.dart';
import 'package:reverse_mortage_loan_app/features/loan_details/presentation/view/controller/loan_details_controller.dart';
import 'package:reverse_mortage_loan_app/features/loan_details/presentation/view/widgets/loan_image_section.dart';
import 'package:reverse_mortage_loan_app/features/loan_details/presentation/view/widgets/loan_info_section.dart';
import 'package:reverse_mortage_loan_app/features/loan_details/presentation/view/widgets/borrower_age_section.dart';
import 'package:reverse_mortage_loan_app/features/loan_details/presentation/view/widgets/home_value_section.dart';

class LoanDetailsScreen extends GetView<LoanDetailsController> {
  const LoanDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: AppColors.white, size: 30),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: const Text(
          'Loan Details',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.containerHighlight,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LoanImageSection(
                              imageUrls: controller.imageUrls,
                              currentIndex: controller.currentImageIndex,
                              pageController: controller.pageController,
                            ),
                            const SizedBox(height: 16),
                            LoanInfoSection(
                              date: controller.date,
                              objective: controller.objective,
                              loanType: controller.loanType,
                              loanAmount: controller.loanAmount,
                              downPayment: controller.downPayment,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),
                      BorrowerAgeSection(
                        firstBorrowerAge: controller.firstBorrowerAge,
                        secondBorrowerAge: controller.secondBorrowerAge,
                      ),
                      const SizedBox(height: 16),
                      HomeValueSection(homeValue: controller.homeValue),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CustomButton(
                  text: 'Request for more information.',
                  onPressed: controller.onRequestMoreInfo,
                  textColor: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
