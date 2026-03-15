import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/features/home/presentation/view/controller/home_controller.dart';

class MainController extends GetxController {
  final selectedIndex = 0.obs;
  late final PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
  }

  void onNavTap(int index) {
    if (selectedIndex.value == index) return;
    final previous = selectedIndex.value;
    selectedIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    if (index == 0 && previous != 0) {
      Get.find<HomeController>().onReturnToHome();
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
