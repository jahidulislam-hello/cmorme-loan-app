class CalculateLoanResponseModel {
  final String id;
  final String userId;
  final String financeType;
  final List<String> homeImg;
  final double homeValue;
  final double mortgageAmount;
  final int? singleBorrowerAge;
  final int? multipleBorrowerAge1;
  final int? multipleBorrowerAge2;

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
    required this.mortgageAmount,
    this.singleBorrowerAge,
    this.multipleBorrowerAge1,
    this.multipleBorrowerAge2,
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
      homeImg: List<String>.from(data['home_img'] as List),
      homeValue: (data['home_value'] as num).toDouble(),
      mortgageAmount: (data['Mortgage_amount'] as num).toDouble(),
      singleBorrowerAge: data['single_borrwer_age'] as int?,
      multipleBorrowerAge1: data['multiple_borrwer_age1'] as int?,
      multipleBorrowerAge2: data['multiple_borrwer_age2'] as int?,
      reverseRefinanceNonGovtLoanAmount:
          (data['reverse_refinance_non_govt_loan_Amount'] as num?)?.toDouble(),
      reverseRefinanceNonGovtCashAvailable:
          (data['reverse_refinance_non_govt_cash_available'] as num?)?.toDouble(),
      reverseRefinanceGovtLoanAmount:
          (data['reverse_refinance_govt_loan_Amount'] as num?)?.toDouble(),
      reverseRefinanceGovtCashAvailable:
          (data['reverse_refinance_govt_cash_available'] as num?)?.toDouble(),
      reversePurchaseNonGovtLoanAmount:
          (data['peverse_purchase_non_govt_loan_Amount'] as num?)?.toDouble(),
      reversePurchaseNonGovtDownPayment:
          (data['peverse_purchase_non_govt_down_payment'] as num?)?.toDouble(),
      reversePurchaseGovtLoanAmount:
          (data['peverse_purchase_govt_loan_Amount'] as num?)?.toDouble(),
      reversePurchaseGovtDownPayment:
          (data['peverse_purchase_govt_down_payment'] as num?)?.toDouble(),
    );
  }
}
