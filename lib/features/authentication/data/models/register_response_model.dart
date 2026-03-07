class RegisterResponseModel {
  final bool success;
  final int statusCode;
  final String message;
  final String token;

  RegisterResponseModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.token,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      success: json['success'] as bool,
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      token: json['data']['token'] as String,
    );
  }
}
