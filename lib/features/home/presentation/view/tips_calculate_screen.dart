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

  static const int _tipCount = 4;
  late List<bool> _visibleTips;

  static const _slideDuration = Duration(milliseconds: 600);
  static const _intervalDuration = Duration(milliseconds: 1800);

  @override
  void initState() {
    super.initState();

    _visibleTips = List.filled(_tipCount, false);

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..forward();

    final controller = Get.find<TipsCalculateController>();

    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.onProgressCompleted();
      }
    });

    // Stop the progress animation if the API call fails
    ever(controller.isApiError, (bool hasError) {
      if (hasError) _progressController.stop();
    });

    // Start animation only when tips are ready (API responded or 2s timeout)
    ever(controller.tipsReady, (bool ready) {
      if (ready && mounted) _startTipsAnimation();
    });
    // In case tipsReady was already true before ever was registered
    if (controller.tipsReady.value) _startTipsAnimation();
  }

  Future<void> _startTipsAnimation() async {
    for (int i = 0; i < _tipCount; i++) {
      if (!mounted) return;
      setState(() => _visibleTips[i] = true);
      await Future.delayed(_intervalDuration);
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // Use smaller font & spacing on short screens (< 680px logical height)
    final isSmallScreen = screenHeight < 680;
    final tipFontSize = isSmallScreen ? 14.0 : 16.0;
    final titleFontSize = isSmallScreen ? 20.0 : 24.0;
    final topSpacing = isSmallScreen ? 16.0 : 32.0;
    final tipSpacing = isSmallScreen ? 10.0 : 16.0;
    final bottomSpacing = isSmallScreen ? 16.0 : 40.0;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: topSpacing),

              /// Title
              Center(
                child: Text(
                  'DID YOU KNOW!',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: topSpacing),

              /// Tips — scrollable so content never overflows on small devices
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(_tipCount, (index) {
                      final isVisible = _visibleTips[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: tipSpacing),
                        child: AnimatedSlide(
                          offset:
                              isVisible ? Offset.zero : const Offset(0.4, 0),
                          duration: _slideDuration,
                          curve: Curves.easeOutCubic,
                          child: AnimatedOpacity(
                            opacity: isVisible ? 1.0 : 0.0,
                            duration: _slideDuration,
                            curve: Curves.easeOutCubic,
                            // Inner Obx: scoped to just this tip's text.
                            child: Obx(() => _buildTipItem(
                                  index,
                                  Get.find<TipsCalculateController>().tips,
                                  tipFontSize,
                                )),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),

              /// Progress Bar or Error State
              Obx(() {
                final controller = Get.find<TipsCalculateController>();
                if (controller.isApiError.value) {
                  return Column(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Color(0xFFE5A429),
                        size: 40,
                      ),
                      const SizedBox(height: 12),
                      const Center(
                        child: Text(
                          'Something went wrong.',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () => Get.back(),
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFFE5A429),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Go Back',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return AnimatedBuilder(
                  animation: _progressController,
                  // Built once and reused every frame — never rebuilt by the animation.
                  child: Center(
                    child: Text(
                      'Please Wait...',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: isSmallScreen ? 18.0 : 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
                              backgroundColor: AppColors.white,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFFE5A429),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        child!,
                      ],
                    );
                  },
                );
              }),

              SizedBox(height: bottomSpacing),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTipItem(int index, List<String> tips, double fontSize) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            index < tips.length ? tips[index] : '',
            style: TextStyle(
              color: AppColors.white,
              fontSize: fontSize,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
