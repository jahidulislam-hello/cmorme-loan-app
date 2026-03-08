import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/shared/app_image/app_images.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class OurBlogScreen extends StatelessWidget {
  const OurBlogScreen({super.key});

  static const String _blogText1 =
      'Ryan Kleis and Robert Rosa, founders of Reverse Mortgage Educators, Inc., have been helping clients stay in their homes and/or purchase new houses with the Federal Housing Administration (FHA) Insured Reverse Mortgage for the past ten years. Recently, Ryan and Robert had the pleasure of meeting former Major League Baseball player, 1974 National League MVP, and 4 consecutive Gold Glove winner, Steve Garvey. After spending time learning about Reverse Mortgage Educators and the benefits of their product, he signed on as a spokesperson. During their time together, Steve had a few great questions about Reverse Mortgages:';

  static const String _steveQuestion =
      'Steve Garvey asked, "Recently there has been a lot of news and advertisements about Reverse Mortgages, so can you explain how a homeowner can get a Reverse Mortgage on a home and not have to make any monthly mortgage payments?"';

  static const String _kleisAnswer =
      'Kleis explained, "Steve, when someone has a traditional mortgage, a statement arrives every month and the homeowner is required to send in the amount due. However, if they had a Reverse Mortgage, the homeowner is not required to send in a monthly mortgage payment when the statement is received. Instead, the interest and mortgage insurance for that month is simply added to the balance. Regardless of their mortgage balance, the homeowner stays in their home for their entire life without making a monthly mortgage payment."';

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
          'Our Blog',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _bodyText(_blogText1),
              const SizedBox(height: 16),
              _quoteText(_steveQuestion),
              const SizedBox(height: 16),
              _bodyText(_kleisAnswer),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  AppImages.educate,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              _bodyText(_blogText1),
              const SizedBox(height: 16),
              _quoteText(_steveQuestion),
              const SizedBox(height: 16),
              _bodyText(_kleisAnswer),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bodyText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.white,
        fontSize: 13,
        height: 1.6,
      ),
    );
  }

  Widget _quoteText(String text) {
    return Container(
      padding: const EdgeInsets.only(left: 12),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(color: AppColors.blue300, width: 3),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.blue100,
          fontSize: 13,
          height: 1.6,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
