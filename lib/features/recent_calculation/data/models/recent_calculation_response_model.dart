class RecentCalculationItemModel {
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

  final DateTime createdAt;

  RecentCalculationItemModel({
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
    required this.createdAt,
  });

  bool get isPurchase => financeType == 'peverse_purchase';

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
      'reverse_refinance_non_govt_loan_Amount': reverseRefinanceNonGovtLoanAmount,
      'reverse_refinance_non_govt_cash_available': reverseRefinanceNonGovtCashAvailable,
      'reverse_refinance_govt_loan_Amount': reverseRefinanceGovtLoanAmount,
      'reverse_refinance_govt_cash_available': reverseRefinanceGovtCashAvailable,
      'peverse_purchase_non_govt_loan_Amount': reversePurchaseNonGovtLoanAmount,
      'peverse_purchase_non_govt_down_payment': reversePurchaseNonGovtDownPayment,
      'peverse_purchase_govt_loan_Amount': reversePurchaseGovtLoanAmount,
      'peverse_purchase_govt_down_payment': reversePurchaseGovtDownPayment,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory RecentCalculationItemModel.fromJson(Map<String, dynamic> json) {
    return RecentCalculationItemModel(
      id: json['_id'] as String,
      userId: json['user_id'] as String,
      financeType: json['finance_type'] as String,
      homeImg: List<String>.from(json['home_img'] as List),
      homeValue: (json['home_value'] as num).toDouble(),
      mortgageAmount: (json['Mortgage_amount'] as num).toDouble(),
      singleBorrowerAge: json['single_borrwer_age'] as int?,
      multipleBorrowerAge1: json['multiple_borrwer_age1'] as int?,
      multipleBorrowerAge2: json['multiple_borrwer_age2'] as int?,
      reverseRefinanceNonGovtLoanAmount:
          (json['reverse_refinance_non_govt_loan_Amount'] as num?)?.toDouble(),
      reverseRefinanceNonGovtCashAvailable:
          (json['reverse_refinance_non_govt_cash_available'] as num?)?.toDouble(),
      reverseRefinanceGovtLoanAmount:
          (json['reverse_refinance_govt_loan_Amount'] as num?)?.toDouble(),
      reverseRefinanceGovtCashAvailable:
          (json['reverse_refinance_govt_cash_available'] as num?)?.toDouble(),
      reversePurchaseNonGovtLoanAmount:
          (json['peverse_purchase_non_govt_loan_Amount'] as num?)?.toDouble(),
      reversePurchaseNonGovtDownPayment:
          (json['peverse_purchase_non_govt_down_payment'] as num?)?.toDouble(),
      reversePurchaseGovtLoanAmount:
          (json['peverse_purchase_govt_loan_Amount'] as num?)?.toDouble(),
      reversePurchaseGovtDownPayment:
          (json['peverse_purchase_govt_down_payment'] as num?)?.toDouble(),
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
  final List<RecentCalculationItemModel> data;

  RecentCalculationResponseModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.pagination,
    required this.data,
  });

  factory RecentCalculationResponseModel.fromJson(Map<String, dynamic> json) {
    final dataObj = json['data'] as Map<String, dynamic>;
    return RecentCalculationResponseModel(
      success: json['success'] as bool,
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      pagination: RecentCalculationPaginationModel.fromJson(
          dataObj['pagination'] as Map<String, dynamic>),
      data: (dataObj['data'] as List)
          .map((e) => RecentCalculationItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
