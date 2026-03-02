import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class TestimonialScreen extends StatelessWidget {
  const TestimonialScreen({super.key});

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
          'Testimonial',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Below are just a few testimonials we\'ve received from the many clients we\'ve helped secure a Reverse Mortgage.',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 13,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 24),
              _TestimonialCard(
                headline: 'ROBERT IS THE BEST REVERSE MORTGAGE CONSULTANT ANYONE COULD ASK FOR.',
                body:
                    'Due to a wonderful advertisement in the LA Times I called Reverse Mortgage Educators. I wanted someone who could explain all of the ins and outs of a reverse mortgage to me and Robert did that in the most understandable language. Robert is caring, thoughtful and always follows up on what he said he would do. He always responded in a timely manner to all my questions and always returned my calls as soon as he could. I never had an occasion when I could not reach him. In essence, Robert is the best consultant anyone could ask for when it comes to Reverse Mortgage.',
                attribution: '— Kay M., Lake Forest, CA',
              ),
              const SizedBox(height: 20),
              _TestimonialCard(
                headline: 'A REVERSE MORTGAGE WAS A WIN-WIN!',
                body:
                    'I was unaware that I could use a Reverse Mortgage to buy my next home in one transaction. I sold my old home and bought a brand new construction home using a Reverse Mortgage for Purchase. I no longer have a monthly mortgage payment and more available cash for retirement! Using a Reverse Mortgage to buy my brand new home was a win, win.',
                attribution: '— Susan E., Palm Desert, CA',
              ),
              const SizedBox(height: 20),
              _TestimonialCard(
                headline: 'A REVERSE MORTGAGE WAS A WIN-WIN!',
                body:
                    'I was unaware that I could use a Reverse Mortgage to buy my next home in one transaction. I sold my old home and bought a brand new construction home using a Reverse Mortgage for Purchase. I no longer have a monthly mortgage payment and more available cash for retirement! Using a Reverse Mortgage to buy my brand new home was a win, win.',
                attribution: '— Susan E., Palm Desert, CA',
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final String headline;
  final String body;
  final String attribution;

  const _TestimonialCard({
    required this.headline,
    required this.body,
    required this.attribution,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.containerHighlight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headline,
            style: const TextStyle(
              color: AppColors.blue300,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            body,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 13,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              attribution,
              style: const TextStyle(
                color: AppColors.hintGrey,
                fontSize: 13,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
