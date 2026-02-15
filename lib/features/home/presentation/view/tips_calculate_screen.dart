import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class TipsCalculateScreen extends StatefulWidget {
  const TipsCalculateScreen({super.key});

  @override
  State<TipsCalculateScreen> createState() => _TipsCalculateScreenState();
}

class _TipsCalculateScreenState extends State<TipsCalculateScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;

  final List<String> _tips = [
    'Paying little extra each month can reduce total interest!',
    'Lower monthly payments but increase total cost!',
    'Credit score can affect the loan interest rate you get!',
    'Refinancing later can save money if rates drop!',
    'Comparing multiple lenders helps you find the best deal!',
  ];

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..forward();

    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        final args = Get.arguments as Map<String, dynamic>?;
        Get.offNamed(RouteNames.loanResult, arguments: args);
      }
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),

              /// Title
              const Center(
                child: Text(
                  'DID YOU KNOW!',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              /// Tips List
              ...List.generate(_tips.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '💬',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _tips[index],
                          style: const TextStyle(
                            color: AppColors.hintGrey,
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),

              const Spacer(),

              /// Progress Bar
              AnimatedBuilder(
                animation: _progressController,
                builder: (context, child) {
                  return Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: SizedBox(
                          height: 12,
                          width: double.infinity,
                          child: LinearProgressIndicator(
                            value: _progressController.value,
                            backgroundColor: AppColors.containerHighlight,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFFE5A429),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Center(
                        child: Text(
                          'Please Wait',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
