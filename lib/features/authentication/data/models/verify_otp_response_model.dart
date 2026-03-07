class VerifyOtpResponseModel {
  final bool success;
  final int statusCode;
  final String message;
  final String id;
  final String email;

  VerifyOtpResponseModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.id,
    required this.email,
  });

  factory VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponseModel(
      success: json['success'] as bool,
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      id: json['data']['_id'] as String,
      email: json['data']['email'] as String,
    );
  }
}
