class RequestProposalDataModel {
  final String id;
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String status;
  final bool isCompleted;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  RequestProposalDataModel({
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
  });

  factory RequestProposalDataModel.fromJson(Map<String, dynamic> json) {
    return RequestProposalDataModel(
      id: json['_id'] as String,
      userId: json['user_id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      status: json['status'] as String,
      isCompleted: json['isCompleted'] as bool,
      isDeleted: json['isDeleted'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}

class RequestProposalResponseModel {
  final bool success;
  final int statusCode;
  final String message;
  final RequestProposalDataModel data;

  RequestProposalResponseModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory RequestProposalResponseModel.fromJson(Map<String, dynamic> json) {
    return RequestProposalResponseModel(
      success: json['success'] as bool,
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      data: RequestProposalDataModel.fromJson(
          json['data'] as Map<String, dynamic>),
    );
  }
}
