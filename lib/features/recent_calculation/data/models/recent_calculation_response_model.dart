class RecentCalculationItemModel {
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
  final bool govtEligible;
  final String? govtNotEligibleReason;
  final bool nonGovtEligible;
  final String? nonGovtNotEligibleReason;

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

  final DateTime createdAt;

  RecentCalculationItemModel({
    required this.id,
    required this.userId,
    required this.financeType,
    required this.homeImg,
    required this.homeValue,
    this.mortgageAmount,
    this.singleBorrowerAge,
    this.multipleBorrowerAge1,
    this.multipleBorrowerAge2,
    required this.govtEligible,
    this.govtNotEligibleReason,
    required this.nonGovtEligible,
    this.nonGovtNotEligibleReason,
    this.reverseRefinanceNonGovtLoanAmount,
    this.reverseRefinanceNonGovtCashAvailable,
    this.reverseRefinanceGovtLoanAmount,
    this.reverseRefinanceGovtCashAvailable,
    this.reversePurchaseNonGovtLoanAmount,
    this.reversePurchaseNonGovtDownPayment,
    this.reversePurchaseGovtLoanAmount,
    this.reversePurchaseGovtDownPayment,
    required this.createdAt,
  });

  bool get isPurchase => financeType == 'reverse_purchase';

  /// Govt loan amount regardless of finance type
  double get govtLoanAmount =>
      isPurchase
          ? (reversePurchaseGovtLoanAmount ?? 0)
          : (reverseRefinanceGovtLoanAmount ?? 0);

  /// Cash available (refinance) or down payment (purchase)
  double get govtCashOrDownPayment =>
      isPurchase
          ? (reversePurchaseGovtDownPayment ?? 0)
          : (reverseRefinanceGovtCashAvailable ?? 0);

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user_id': userId,
      'finance_type': financeType,
      'home_img': homeImg,
      'home_value': homeValue,
      'Mortgage_amount': mortgageAmount,
      'single_borrwer_age': singleBorrowerAge,
      'multiple_borrwer_age1': multipleBorrowerAge1,
      'multiple_borrwer_age2': multipleBorrowerAge2,
      'govt_eligible': govtEligible,
      'govt_not_eligible_reason': govtNotEligibleReason,
      'non_govt_eligible': nonGovtEligible,
      'non_govt_not_eligible_reason': nonGovtNotEligibleReason,
      'reverse_refinance_non_govt_loan_Amount': reverseRefinanceNonGovtLoanAmount,
      'reverse_refinance_non_govt_cash_available': reverseRefinanceNonGovtCashAvailable,
      'reverse_refinance_govt_loan_Amount': reverseRefinanceGovtLoanAmount,
      'reverse_refinance_govt_cash_available': reverseRefinanceGovtCashAvailable,
      'reverse_purchase_non_govt_loan_Amount': reversePurchaseNonGovtLoanAmount,
      'reverse_purchase_non_govt_down_payment': reversePurchaseNonGovtDownPayment,
      'reverse_purchase_govt_loan_Amount': reversePurchaseGovtLoanAmount,
      'reverse_purchase_govt_down_payment': reversePurchaseGovtDownPayment,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory RecentCalculationItemModel.fromJson(Map<String, dynamic> json) {
    return RecentCalculationItemModel(
      id: json['_id'] as String,
      userId: json['user_id'] is Map
          ? (json['user_id'] as Map<String, dynamic>)['_id'] as String
          : json['user_id'] as String,
      financeType: json['finance_type'] as String,
      homeImg: List<String>.from(json['home_img'] as List? ?? []),
      homeValue: (json['home_value'] as num).toDouble(),
      mortgageAmount: (json['Mortgage_amount'] as num?)?.toDouble(),
      singleBorrowerAge: json['single_borrwer_age'] as int?,
      multipleBorrowerAge1: json['multiple_borrwer_age1'] as int?,
      multipleBorrowerAge2: json['multiple_borrwer_age2'] as int?,
      govtEligible: json['govt_eligible'] as bool? ?? json['govt_loan_available'] as bool? ?? false,
      govtNotEligibleReason: json['govt_not_eligible_reason'] as String?,
      nonGovtEligible: json['non_govt_eligible'] as bool? ?? json['non_govt_loan_available'] as bool? ?? false,
      nonGovtNotEligibleReason: json['non_govt_not_eligible_reason'] as String?,
      reverseRefinanceNonGovtLoanAmount:
          (json['reverse_refinance_non_govt_loan_Amount'] as num?)?.toDouble(),
      reverseRefinanceNonGovtCashAvailable:
          (json['reverse_refinance_non_govt_cash_available'] as num?)?.toDouble(),
      reverseRefinanceGovtLoanAmount:
          (json['reverse_refinance_govt_loan_Amount'] as num?)?.toDouble(),
      reverseRefinanceGovtCashAvailable:
          (json['reverse_refinance_govt_cash_available'] as num?)?.toDouble(),
      reversePurchaseNonGovtLoanAmount:
          (json['reverse_purchase_non_govt_loan_Amount'] as num?)?.toDouble(),
      reversePurchaseNonGovtDownPayment:
          (json['reverse_purchase_non_govt_down_payment'] as num?)?.toDouble(),
      reversePurchaseGovtLoanAmount:
          (json['reverse_purchase_govt_loan_Amount'] as num?)?.toDouble(),
      reversePurchaseGovtDownPayment:
          (json['reverse_purchase_govt_down_payment'] as num?)?.toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}

class RecentCalculationPaginationModel {
  final int totalPage;
  final int currentPage;
  final int prevPage;
  final int nextPage;
  final int totalData;

  RecentCalculationPaginationModel({
    required this.totalPage,
    required this.currentPage,
    required this.prevPage,
    required this.nextPage,
    required this.totalData,
  });

  factory RecentCalculationPaginationModel.fromJson(Map<String, dynamic> json) {
    return RecentCalculationPaginationModel(
      totalPage: json['totalPage'] as int,
      currentPage: json['currentPage'] as int,
      prevPage: json['prevPage'] as int,
      nextPage: json['nextPage'] as int,
      totalData: json['totalData'] as int,
    );
  }
}

class RecentCalculationResponseModel {
  final bool success;
  final int statusCode;
  final String message;
  final RecentCalculationPaginationModel pagination;
  final double govt;
  final double nonGovt;
  final List<RecentCalculationItemModel> data;

  RecentCalculationResponseModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.pagination,
    required this.govt,
    required this.nonGovt,
    required this.data,
  });

  /// Constructs a response from locally cached items when offline.
  factory RecentCalculationResponseModel.fromCache(
      List<RecentCalculationItemModel> data) {
    return RecentCalculationResponseModel(
      success: true,
      statusCode: 200,
      message: 'cached',
      pagination: RecentCalculationPaginationModel(
        totalPage: 1,
        currentPage: 1,
        prevPage: 0,
        nextPage: 0,
        totalData: data.length,
      ),
      govt: 0,
      nonGovt: 0,
      data: data,
    );
  }

  factory RecentCalculationResponseModel.fromJson(Map<String, dynamic> json) {
    final dataObj = json['data'] as Map<String, dynamic>;
    return RecentCalculationResponseModel(
      success: json['success'] as bool,
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      pagination: RecentCalculationPaginationModel.fromJson(
          json['pagination'] as Map<String, dynamic>),
      govt: (dataObj['govt'] as num?)?.toDouble() ?? 0,
      nonGovt: (dataObj['nonGovt'] as num?)?.toDouble() ?? 0,
      data: (dataObj['data'] as List)
          .map((e) => RecentCalculationItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
