import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';

class LoanDetailsController extends GetxController {
  final String date = '08 Jan 2026';
  final String objective = 'Reverse Finance';
  final String loanAmount = '\$1500';
  final String cashAvailable = '\$1500';
  final String? downPayment = null;
  final String firstBorrowerAge = '55';
  final String? secondBorrowerAge = '75';
  final String homeValue = '\$1500';

  final List<String> imageUrls = [
    'assets/images/dummy_house.png',
    'assets/images/dummy_house.png',
    'assets/images/dummy_house.png',
  ];

  final currentImageIndex = 0.obs;
  late final PageController pageController;

  bool get hasTwoBorrowers => secondBorrowerAge != null;
  bool get hasDownPayment => downPayment != null;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onRequestMoreInfo() {
    Get.toNamed(RouteNames.requestProposal);
  }
}
