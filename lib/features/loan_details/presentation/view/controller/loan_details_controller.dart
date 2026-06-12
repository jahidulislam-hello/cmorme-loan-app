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
  late final bool govtLoanAvailable;
  late final String? govtNotEligibleReason;
  late final String govtLoanAmount;
  late final String govtCashAvailable;
  late final String govtCashAvailableLabel;
  late final String? govtDownPayment;

  // Non-govt section
  late final bool nonGovtEligible;
  late final bool nonGovtLoanAvailable;
  late final String? nonGovtNotEligibleReason;
  late final String nonGovtLoanAmount;
  late final String nonGovtCashAvailable;
  late final String nonGovtCashAvailableLabel;
  late final String? nonGovtDownPayment;
  late final bool showNonGovtAgeDisclaimer;

  // Raw values for conditional display in UI
  late final double rawGovtCashAvailable;
  late final double rawNonGovtCashAvailable;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    try {
      _item = Get.arguments as RecentCalculationItemModel;
      _mapFields();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load loan details.');
      Get.back();
    }
  }

  static final _dateFmt = DateFormat('dd MMM yyyy');
  static final _numFmt = NumberFormat('#,##0.##');

  void _mapFields() {
    imageUrls = _item.homeImg
        .map((path) => '${ApiConstants.imageBaseUrl}$path')
        .toList();

    date = _dateFmt.format(_item.createdAt);
    objective = _item.isPurchase ? 'Reverse for Purchase' : 'Reverse Refinance';
    homeValue = '\$${_numFmt.format(_item.homeValue)}';

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
    govtLoanAvailable = _item.govtLoanAvailable;
    govtNotEligibleReason = _item.govtNotEligibleReason;
    nonGovtEligible = _item.nonGovtEligible;
    nonGovtLoanAvailable = _item.nonGovtLoanAvailable;
    nonGovtNotEligibleReason = _item.nonGovtNotEligibleReason;

    final age1 = _item.multipleBorrowerAge1;
    final age2 = _item.multipleBorrowerAge2;
    showNonGovtAgeDisclaimer = nonGovtLoanAvailable &&
        ((age1 != null && age1 < 55) || (age2 != null && age2 < 55));

    rawGovtCashAvailable = _item.reverseRefinanceGovtCashAvailable ?? 0;
    rawNonGovtCashAvailable = _item.reverseRefinanceNonGovtCashAvailable ?? 0;

    if (_item.isPurchase) {
      govtLoanAmount = '\$${_numFmt.format(_item.reversePurchaseGovtLoanAmount ?? 0)}';
      govtCashAvailable = '\$${_numFmt.format(0)}';
      govtCashAvailableLabel = 'Cash Available';
      govtDownPayment = '\$${_numFmt.format(_item.reversePurchaseGovtDownPayment ?? 0)}';

      nonGovtLoanAmount = '\$${_numFmt.format(_item.reversePurchaseNonGovtLoanAmount ?? 0)}';
      nonGovtCashAvailable = '\$${_numFmt.format(0)}';
      nonGovtCashAvailableLabel = 'Cash Available';
      nonGovtDownPayment = '\$${_numFmt.format(_item.reversePurchaseNonGovtDownPayment ?? 0)}';
    } else {
      govtLoanAmount = '\$${_numFmt.format(_item.reverseRefinanceGovtLoanAmount ?? 0)}';
      govtCashAvailable = '\$${_numFmt.format(rawGovtCashAvailable.abs())}';
      govtCashAvailableLabel = rawGovtCashAvailable < 0 ? 'Short to close by:' : 'Cash Available';
      govtDownPayment = null;

      nonGovtLoanAmount = '\$${_numFmt.format(_item.reverseRefinanceNonGovtLoanAmount ?? 0)}';
      nonGovtCashAvailable = '\$${_numFmt.format(rawNonGovtCashAvailable.abs())}';
      nonGovtCashAvailableLabel = rawNonGovtCashAvailable < 0 ? 'Short to close by:' : 'Cash Available';
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
