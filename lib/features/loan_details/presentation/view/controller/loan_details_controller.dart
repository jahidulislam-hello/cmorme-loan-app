import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/core/constants/api_constants.dart';
import 'package:reverse_mortage_loan_app/features/recent_calculation/data/models/recent_calculation_response_model.dart';

class LoanDetailsController extends GetxController {
  late final RecentCalculationItemModel _item;

  final currentImageIndex = 0.obs;
  late final PageController pageController;

  // Image URLs with baseUrl prepended
  late final List<String> imageUrls;

  // Info section
  late final String date;
  late final String objective;
  late final String homeValue;
  late final String firstBorrowerAge;
  late final String? secondBorrowerAge;

  // Govt section
  late final bool govtEligible;
  late final String? govtNotEligibleReason;
  late final String govtLoanAmount;
  late final String govtCashAvailable;
  late final String? govtDownPayment;

  // Non-govt section
  late final bool nonGovtEligible;
  late final String? nonGovtNotEligibleReason;
  late final String nonGovtLoanAmount;
  late final String nonGovtCashAvailable;
  late final String? nonGovtDownPayment;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    _item = Get.arguments as RecentCalculationItemModel;
    _mapFields();
  }

  void _mapFields() {
    final fmt = NumberFormat('#,##0.##');

    imageUrls = _item.homeImg
        .map((path) => '${ApiConstants.imageBaseUrl}$path')
        .toList();

    date = DateFormat('dd MMM yyyy').format(_item.createdAt);
    objective = _item.isPurchase ? 'Reverse for Purchase' : 'Reverse Refinance';
    homeValue = '\$${fmt.format(_item.homeValue)}';

    if (_item.multipleBorrowerAge1 != null) {
      firstBorrowerAge = '${_item.multipleBorrowerAge1}';
      secondBorrowerAge = _item.multipleBorrowerAge2 != null
          ? '${_item.multipleBorrowerAge2}'
          : null;
    } else {
      firstBorrowerAge = '${_item.singleBorrowerAge ?? '-'}';
      secondBorrowerAge = null;
    }

    govtEligible = _item.govtEligible;
    govtNotEligibleReason = _item.govtNotEligibleReason;
    nonGovtEligible = _item.nonGovtEligible;
    nonGovtNotEligibleReason = _item.nonGovtNotEligibleReason;

    if (_item.isPurchase) {
      govtLoanAmount = '\$${fmt.format(_item.reversePurchaseGovtLoanAmount ?? 0)}';
      govtCashAvailable = '\$${fmt.format(0)}';
      govtDownPayment = '\$${fmt.format(_item.reversePurchaseGovtDownPayment ?? 0)}';

      nonGovtLoanAmount = '\$${fmt.format(_item.reversePurchaseNonGovtLoanAmount ?? 0)}';
      nonGovtCashAvailable = '\$${fmt.format(0)}';
      nonGovtDownPayment = '\$${fmt.format(_item.reversePurchaseNonGovtDownPayment ?? 0)}';
    } else {
      govtLoanAmount = '\$${fmt.format(_item.reverseRefinanceGovtLoanAmount ?? 0)}';
      govtCashAvailable = '\$${fmt.format(_item.reverseRefinanceGovtCashAvailable ?? 0)}';
      govtDownPayment = null;

      nonGovtLoanAmount = '\$${fmt.format(_item.reverseRefinanceNonGovtLoanAmount ?? 0)}';
      nonGovtCashAvailable = '\$${fmt.format(_item.reverseRefinanceNonGovtCashAvailable ?? 0)}';
      nonGovtDownPayment = null;
    }
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
