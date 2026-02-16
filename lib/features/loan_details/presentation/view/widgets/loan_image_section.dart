import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class LoanImageSection extends StatelessWidget {
  final List<String> imageUrls;
  final RxInt currentIndex;
  final PageController pageController;

  const LoanImageSection({
    super.key,
    required this.imageUrls,
    required this.currentIndex,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: PageView.builder(
              controller: pageController,
              itemCount: imageUrls.length,
              onPageChanged: (index) => currentIndex.value = index,
              itemBuilder: (context, index) {
                return Image.asset(
                  imageUrls[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              },
            ),
          ),
        ),
        if (imageUrls.length > 1) ...[
          const SizedBox(height: 12),
          Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(imageUrls.length, (index) {
              final isActive = index == currentIndex.value;
              return Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive ? AppColors.white : AppColors.primary,
                ),
              );
            }),
          )),
        ],
      ],
    );
  }
}
