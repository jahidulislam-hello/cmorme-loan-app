import 'user_model.dart';

class LoginResponseModel {
  final bool success;
  final int statusCode;
  final String message;
  final UserModel user;
  final String token;

  LoginResponseModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.user,
    required this.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'] as bool,
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      user: UserModel.fromJson(json['data']['user'] as Map<String, dynamic>),
      token: json['data']['token'] as String,
    );
  }
}
