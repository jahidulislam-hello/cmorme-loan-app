import 'profile_model.dart';

class UpdateProfileResponseModel {
  final bool success;
  final int statusCode;
  final String message;
  final ProfileModel profile;

  UpdateProfileResponseModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.profile,
  });

  factory UpdateProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponseModel(
      success: json['success'] as bool,
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      profile: ProfileModel.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}
