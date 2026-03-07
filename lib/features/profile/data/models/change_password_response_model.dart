class ChangePasswordResponseModel {
  final bool success;
  final int statusCode;
  final String message;

  ChangePasswordResponseModel({
    required this.success,
    required this.statusCode,
    required this.message,
  });

  factory ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponseModel(
      success: json['success'] as bool,
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
    );
  }
}
