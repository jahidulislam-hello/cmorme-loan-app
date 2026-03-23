class CalculateLoanResponseModel {
  final String id;
  final String userId;
  final String financeType;
  final List<String> homeImg;
  final double homeValue;
  final double? mortgageAmount;
  final int? singleBorrowerAge;
  final int? multipleBorrowerAge1;
  final int? multipleBorrowerAge2;

  // Eligibility fields
  final bool isMarried;
  final int? effectiveAge;
  final bool govtEligible;
  final String? govtNotEligibleReason;
  final bool govtLoanAvailable;
  final bool nonGovtEligible;
  final String? nonGovtNotEligibleReason;
  final bool nonGovtLoanAvailable;

  // Reverse Refinance fields
  final double? reverseRefinanceNonGovtLoanAmount;
  final double? reverseRefinanceNonGovtCashAvailable;
  final double? reverseRefinanceGovtLoanAmount;
  final double? reverseRefinanceGovtCashAvailable;

  // Reverse Purchase fields
  final double? reversePurchaseNonGovtLoanAmount;
  final double? reversePurchaseNonGovtDownPayment;
  final double? reversePurchaseGovtLoanAmount;
  final double? reversePurchaseGovtDownPayment;

  CalculateLoanResponseModel({
    required this.id,
    required this.userId,
    required this.financeType,
    required this.homeImg,
    required this.homeValue,
    this.mortgageAmount,
    this.singleBorrowerAge,
    this.multipleBorrowerAge1,
    this.multipleBorrowerAge2,
    required this.isMarried,
    this.effectiveAge,
    required this.govtEligible,
    this.govtNotEligibleReason,
    required this.govtLoanAvailable,
    required this.nonGovtEligible,
    this.nonGovtNotEligibleReason,
    required this.nonGovtLoanAvailable,
    this.reverseRefinanceNonGovtLoanAmount,
    this.reverseRefinanceNonGovtCashAvailable,
    this.reverseRefinanceGovtLoanAmount,
    this.reverseRefinanceGovtCashAvailable,
    this.reversePurchaseNonGovtLoanAmount,
    this.reversePurchaseNonGovtDownPayment,
    this.reversePurchaseGovtLoanAmount,
    this.reversePurchaseGovtDownPayment,
  });

  factory CalculateLoanResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return CalculateLoanResponseModel(
      id: data['_id'] as String,
      userId: data['user_id'] as String,
      financeType: data['finance_type'] as String,
      homeImg: List<String>.from(data['home_img'] as List? ?? []),
      homeValue: (data['home_value'] as num).toDouble(),
      mortgageAmount: (data['Mortgage_amount'] as num?)?.toDouble(),
      singleBorrowerAge: data['single_borrwer_age'] as int?,
      multipleBorrowerAge1: data['multiple_borrwer_age1'] as int?,
      multipleBorrowerAge2: data['multiple_borrwer_age2'] as int?,
      isMarried: data['is_married'] as bool? ?? false,
      effectiveAge: data['effective_age'] as int?,
      govtEligible: data['govt_eligible'] as bool? ?? data['govt_loan_available'] as bool? ?? false,
      govtNotEligibleReason: data['govt_not_eligible_reason'] as String?,
      govtLoanAvailable: data['govt_loan_available'] as bool? ?? false,
      nonGovtEligible: data['non_govt_eligible'] as bool? ?? data['non_govt_loan_available'] as bool? ?? false,
      nonGovtNotEligibleReason: data['non_govt_not_eligible_reason'] as String?,
      nonGovtLoanAvailable: data['non_govt_loan_available'] as bool? ?? false,
      reverseRefinanceNonGovtLoanAmount:
          (data['reverse_refinance_non_govt_loan_Amount'] as num?)?.toDouble(),
      reverseRefinanceNonGovtCashAvailable:
          (data['reverse_refinance_non_govt_cash_available'] as num?)?.toDouble(),
      reverseRefinanceGovtLoanAmount:
          (data['reverse_refinance_govt_loan_Amount'] as num?)?.toDouble(),
      reverseRefinanceGovtCashAvailable:
          (data['reverse_refinance_govt_cash_available'] as num?)?.toDouble(),
      reversePurchaseNonGovtLoanAmount:
          (data['reverse_purchase_non_govt_loan_Amount'] as num?)?.toDouble(),
      reversePurchaseNonGovtDownPayment:
          (data['reverse_purchase_non_govt_down_payment'] as num?)?.toDouble(),
      reversePurchaseGovtLoanAmount:
          (data['reverse_purchase_govt_loan_Amount'] as num?)?.toDouble(),
      reversePurchaseGovtDownPayment:
          (data['reverse_purchase_govt_down_payment'] as num?)?.toDouble(),
    );
  }
}
