import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/features/faq/presentation/view/controller/faq_questions_controller.dart';
import 'package:reverse_mortage_loan_app/features/faq/presentation/view/widgets/faq_item_widget.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class FaqQuestionsScreen extends GetView<FaqQuestionsController> {
  const FaqQuestionsScreen({super.key});

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
          'FAQ',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                'When it comes to a Reverse Mortgage, there\'s a lot the borrower needs to know. And, more importantly, it\'s important that the borrower know enough to decide whether a Reverse Mortgage is right for them. Because we are educators, first and foremost, we\'re here to educate you on everything you need to know to make the right decision for you and your family.',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 13,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Below are just some of the most asked questions we typically receive when educating our clients. If you have a question or questions that have not been addressed, we encourage you to give us a call at: 1-800-800-2180 and one of our educators can take the necessary time to give you the answers you\'re searching for.',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 13,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 24),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.faqItems.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final item = controller.faqItems[index];
                  return Obx(() => FaqItemWidget(
                        question: item.question,
                        answer: item.answer,
                        isExpanded: controller.expandedIndex.value == index,
                        onTap: () => controller.toggleExpanded(index),
                      ));
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
