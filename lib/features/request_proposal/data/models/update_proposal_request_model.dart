class UpdateProposalRequestModel {
  final String address;
  final String city;
  final String stateCode;
  final String phone;
  final String financeType;
  final double homeValue;
  final double mortgageAmount;
  final String spouseDateOfBirth;
  final String contactTime;
  final String responseType;
  final String? setTime;
  final bool isCompleted;

  UpdateProposalRequestModel({
    required this.address,
    required this.city,
    required this.stateCode,
    required this.phone,
    required this.financeType,
    required this.homeValue,
    required this.mortgageAmount,
    required this.spouseDateOfBirth,
    required this.contactTime,
    required this.responseType,
    this.setTime,
    required this.isCompleted,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'address': address,
      'city': city,
      'state_code': stateCode,
      'phone': phone,
      'finance_type': financeType,
      'home_value': homeValue,
      'mortgage_amount': mortgageAmount,
      'Spouse_Date_of_Birth': spouseDateOfBirth,
      'contact_time': contactTime,
      'responseType': responseType,
      'isCompleted': isCompleted,
    };
    if (setTime != null) {
      map['set_time'] = setTime;
    }
    return map;
  }
}
