class MyProposalUserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;

  MyProposalUserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory MyProposalUserModel.fromJson(Map<String, dynamic> json) {
    return MyProposalUserModel(
      id: json['_id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String? ?? '',
      email: json['email'] as String,
    );
  }
}

class MyProposalDataModel {
  final String id;
  final MyProposalUserModel userId;
  final String firstName;
  final String lastName;
  final String email;
  final String status;
  final bool isCompleted;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Nullable — filled in later steps
  final String? address;
  final String? city;
  final String? stateCode;
  final String? phone;
  final String? financeType;
  final double? homeValue;
  final double? mortgageAmount;
  final DateTime? spouseDateOfBirth;
  final String? contactTime;
  final String? responseType;
  final DateTime? setTime;

  MyProposalDataModel({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.status,
    required this.isCompleted,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    this.address,
    this.city,
    this.stateCode,
    this.phone,
    this.financeType,
    this.homeValue,
    this.mortgageAmount,
    this.spouseDateOfBirth,
    this.contactTime,
    this.responseType,
    this.setTime,
  });

  factory MyProposalDataModel.fromJson(Map<String, dynamic> json) {
    // user_id may be a populated object or a plain string id
    final rawUserId = json['user_id'];
    final userModel = rawUserId is Map<String, dynamic>
        ? MyProposalUserModel.fromJson(rawUserId)
        : MyProposalUserModel(
            id: rawUserId as String,
            firstName: '',
            lastName: '',
            email: '',
          );

    return MyProposalDataModel(
      id: json['_id'] as String,
      userId: userModel,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String? ?? '',
      email: json['email'] as String,
      status: json['status'] as String,
      isCompleted: json['isCompleted'] as bool,
      isDeleted: json['isDeleted'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      address: json['address'] as String?,
      city: json['city'] as String?,
      stateCode: json['state_code'] as String?,
      phone: json['phone'] as String?,
      financeType: json['finance_type'] as String?,
      homeValue: (json['home_value'] as num?)?.toDouble(),
      mortgageAmount: (json['mortgage_amount'] as num?)?.toDouble(),
      spouseDateOfBirth: json['Spouse_Date_of_Birth'] != null
          ? DateTime.tryParse(json['Spouse_Date_of_Birth'] as String)
          : null,
      contactTime: json['contact_time'] as String?,
      responseType: json['responseType'] as String?,
      setTime: json['set_time'] != null
          ? DateTime.tryParse(json['set_time'] as String)
          : null,
    );
  }
}

class MyProposalResponseModel {
  final bool success;
  final int statusCode;
  final String message;
  final MyProposalDataModel data;

  MyProposalResponseModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory MyProposalResponseModel.fromJson(Map<String, dynamic> json) {
    return MyProposalResponseModel(
      success: json['success'] as bool,
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      data: MyProposalDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}
