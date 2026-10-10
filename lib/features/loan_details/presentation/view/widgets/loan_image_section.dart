import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_cached_network_image.dart';

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
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: imageUrls.isEmpty
                ? Container(
                    width: double.infinity,
                    height: 200,
                    color: AppColors.blue400,
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image_not_supported_outlined,
                              color: Colors.white54, size: 52),
                          SizedBox(height: 8),
                          Text(
                            'No images available',
                            style: TextStyle(color: Colors.white54, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  )
                : PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: pageController,
                    itemCount: imageUrls.length,
                    onPageChanged: (index) => currentIndex.value = index,
                    itemBuilder: (context, index) {
                      return ColoredBox(
                        color: Colors.black,
                        child: CustomCachedNetworkImage(
                          imageUrl: imageUrls[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      );
                    },
                  ),
          ),
          if (imageUrls.length > 1)
            Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: Obx(() => Row(
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
            ),
        ],
      ),
    );
  }
}
