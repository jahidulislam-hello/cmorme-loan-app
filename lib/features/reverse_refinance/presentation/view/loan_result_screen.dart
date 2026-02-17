import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/features/authentication/presentation/view/controller/auth_controller.dart';
import 'package:reverse_mortage_loan_app/shared/app_image/app_images.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_button.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_horizontal_line.dart';

class LoanResultScreen extends StatelessWidget {
  const LoanResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;
    final type = args?['type'] ?? 'refinance';
    final isPurchase = type == 'purchase';
    final title = isPurchase ? 'Reverse for Purchase' : 'Reverse Refinance';
    final isRealEstate = AuthController.userRole.value == 'real_estate';

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
          title,
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// User info container (real estate only)
                      if (isRealEstate) ...[
                        const SizedBox(height: 16),
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Ankon Akash',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'abcd1234@gmai.com',
                                        style: TextStyle(
                                          color: AppColors.hintGrey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Handle delete
                                  },
                                  child: SvgPicture.asset(
                                    AppImages.deleteIcon,
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                              ],
                            ),
                            CustomHorizontalLine(
                              thickness: 2,
                            )
                          ],
                        ),
                      ],

                      const SizedBox(height: 32),

                      /// Estimated Govt Reverse Mortgage
                      const Text(
                        'Estimated Govt Reverse Mortgage',
                        style: TextStyle(
                          color: AppColors.yellow500,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Loan Amount',
                        style: TextStyle(
                          color: AppColors.blue50,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$1500',
                        style: TextStyle(
                          color: AppColors.green500,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      /// Down Payment (Purchase only)
                      if (isPurchase) ...[
                        const SizedBox(height: 8),
                        const Text(
                          'Down Payment',
                          style: TextStyle(
                            color: AppColors.blue50,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '\$1500',
                          style: TextStyle(
                            color: AppColors.green500,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],

                      const SizedBox(height: 35),

                      /// Estimated Non-Govt Reverse Mortgage
                      const Text(
                        'Estimated Non-Govt Reverse Mortgage',
                        style: TextStyle(
                          color: AppColors.yellow500,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Loan Amount',
                        style: TextStyle(
                          color: AppColors.blue50,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$1500',
                        style: TextStyle(
                          color: AppColors.green500,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      /// Down Payment (Purchase only)
                      if (isPurchase) ...[
                        const SizedBox(height: 8),
                        const Text(
                          'Down Payment',
                          style: TextStyle(
                            color: AppColors.blue50,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '\$1500',
                          style: TextStyle(
                            color: AppColors.green500,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],

                      const Spacer(),

                      /// Calculate Loan Button
                      CustomButton(
                        text: 'Calculate Loan',
                        onPressed: () {
                          // TODO: Calculate loan action
                        },
                        textColor: AppColors.primary,
                      ),
                      const SizedBox(height: 12),

                      /// Request for more info Button
                      CustomButton(
                        text: 'Request for more info.',
                        onPressed: () {
                          // TODO: Request more info action
                        },
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
}
