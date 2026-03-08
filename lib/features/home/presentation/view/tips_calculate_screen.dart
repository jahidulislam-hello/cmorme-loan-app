import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/features/home/presentation/view/controller/tips_calculate_controller.dart';
import 'package:reverse_mortage_loan_app/shared/app_image/app_images.dart';
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

  int _currentTipIndex = 0;
  bool _tipVisible = false;

  static const _fadeDuration = Duration(milliseconds: 250);
  static const _stayDuration = Duration(milliseconds: 900);
  static const _gapDuration = Duration(milliseconds: 50);

  @override
  void initState() {
    super.initState();

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..forward();

    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.find<TipsCalculateController>().onProgressCompleted();
      }
    });

    _startTipsAnimation();
  }

  Future<void> _startTipsAnimation() async {
    for (int i = 0; i < _tips.length; i++) {
      if (!mounted) return;

      // Fade in at this tip's position
      setState(() {
        _currentTipIndex = i;
        _tipVisible = true;
      });

      if (i < _tips.length - 1) {
        // Stay visible
        await Future.delayed(_stayDuration);
        if (!mounted) return;

        // Fade out
        setState(() => _tipVisible = false);
        await Future.delayed(_fadeDuration);

        // Brief gap before next tip
        await Future.delayed(_gapDuration);
      }
      // Last tip: fades in and stays on screen
    }
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

              const SizedBox(height: 48),

              /// Tips — each tip stays at its own list position, animates individually
              Expanded(
                child: Column(
                  children: List.generate(_tips.length, (index) {
                    final isVisible =
                        index == _currentTipIndex && _tipVisible;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: AnimatedOpacity(
                        opacity: isVisible ? 1.0 : 0.0,
                        duration: _fadeDuration,
                        child: _buildTipItem(index),
                      ),
                    );
                  }),
                ),
              ),

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
                          'Please Wait...',
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

  Widget _buildTipItem(int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 56,
          height: 52,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              SvgPicture.asset(
                AppImages.triangleIcon,
                width: 56,
                height: 52,
              ),
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    width: 24,
                    height: 14,
                    decoration: const BoxDecoration(
                      color: AppColors.yellow500,
                      shape: BoxShape.rectangle,
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}'.padLeft(2, '0'),
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            _tips[index],
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 18,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
