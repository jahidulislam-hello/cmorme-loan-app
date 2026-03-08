import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class CalculateOptionsScreen extends StatelessWidget {
  const CalculateOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              /// App Bar
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Would You Like to Calculate',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              /// Reverse Refinance Card
              _CalculateOptionCard(
                title: 'Reverse',
                subtitle: 'Refinance',
                description:
                    'The process of replacing an reverse mortgage\nThe process of replacing an reverse mortgage\nThe process of replacing an reverse mortgage\nThe process of replacing an reverse mortgage',
                gradientColors: const [
                  Color(0xFF2A4066),
                  Color(0xFF3A5A80),
                ],
                onCalculateNow: () {
                  Get.toNamed(RouteNames.reverseRefinance,
                      arguments: {'type': 'refinance'});
                },
              ),

              const SizedBox(height: 24),

              /// Reverse for Purchase Card
              _CalculateOptionCard(
                title: 'Reverse for',
                subtitle: 'Purchase',
                description:
                    'The process of replacing an reverse mortgage\nThe process of replacing an reverse mortgage\nThe process of replacing an reverse mortgage',
                gradientColors: const [
                  Color(0xFF3A4A66),
                  Color(0xFF4A6080),
                ],
                onCalculateNow: () {
                  Get.toNamed(RouteNames.reverseRefinance,
                      arguments: {'type': 'purchase'});
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _CalculateOptionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final List<Color> gradientColors;
  final VoidCallback onCalculateNow;

  const _CalculateOptionCard({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.gradientColors,
    required this.onCalculateNow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
      ),
      child: Stack(
        children: [
          /// Background decorative overlay
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Opacity(
                opacity: 0.15,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/dummy_logo_image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),

          /// Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: TextStyle(
                    color: AppColors.white.withValues(alpha: 0.6),
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: onCalculateNow,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      foregroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Calculate Now!',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
