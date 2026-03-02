import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/features/faq/presentation/view/controller/faq_controller.dart';
import 'package:reverse_mortage_loan_app/features/faq/presentation/view/widgets/faq_option_container.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class FaqScreen extends GetView<FaqController> {
  const FaqScreen({super.key});

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 16),
              FaqOptionContainer(
                title: 'About Us',
                onTap: controller.onAboutUs,
              ),
              const SizedBox(height: 16),
              FaqOptionContainer(
                title: 'Why We Educate',
                onTap: controller.onWhyWeEducate,
              ),
              const SizedBox(height: 16),
              FaqOptionContainer(
                title: 'Frequently Asked Question',
                onTap: controller.onFrequentlyAskedQuestion,
              ),
              const SizedBox(height: 16),
              FaqOptionContainer(
                title: 'Our Blog',
                onTap: controller.onOurBlog,
              ),
              const SizedBox(height: 16),
              FaqOptionContainer(
                title: 'Testimonial',
                onTap: controller.onTestimonial,
              ),
              const SizedBox(height: 16),
              FaqOptionContainer(
                title: 'Instant Quote',
                onTap: controller.onInstantQuote,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
