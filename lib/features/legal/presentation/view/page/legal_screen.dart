import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/features/legal/presentation/view/controller/legal_controller.dart';

class LegalScreen extends GetView<LegalController> {
  const LegalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String title = Get.arguments as String? ?? 'Legal';

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
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          itemCount: controller.legalItems.length,
          separatorBuilder: (_, __) => const SizedBox(height: 20),
          itemBuilder: (context, index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: AppColors.yellow500,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    controller.legalItems[index],
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
