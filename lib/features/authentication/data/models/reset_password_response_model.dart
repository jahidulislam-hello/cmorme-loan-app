class ResetPasswordResponseModel {
  final bool success;
  final int statusCode;
  final String message;

  ResetPasswordResponseModel({
    required this.success,
    required this.statusCode,
    required this.message,
  });

  factory ResetPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponseModel(
      success: json['success'] as bool,
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
    );
  }
}
