class CalculateLoanRequestModel {
  final String financeType;
  final double homeValue;
  final List<String> homeImg;
  final double? mortgageAmount;
  final int? singleBorrowerAge;
  final int? multipleBorrowerAge1;
  final int? multipleBorrowerAge2;

  CalculateLoanRequestModel({
    required this.financeType,
    required this.homeValue,
    this.homeImg = const [],
    this.mortgageAmount,
    this.singleBorrowerAge,
    this.multipleBorrowerAge1,
    this.multipleBorrowerAge2,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'finance_type': financeType,
      'home_value': homeValue,
    };
    if (homeImg.isNotEmpty) {
      map['home_img'] = homeImg;
    }
    if (mortgageAmount != null) {
      map['Mortgage_amount'] = mortgageAmount;
    }
    if (singleBorrowerAge != null) {
      map['single_borrwer_age'] = singleBorrowerAge;
    }
    if (multipleBorrowerAge1 != null) {
      map['multiple_borrwer_age1'] = multipleBorrowerAge1;
    }
    if (multipleBorrowerAge2 != null) {
      map['multiple_borrwer_age2'] = multipleBorrowerAge2;
    }
    return map;
  }
}
