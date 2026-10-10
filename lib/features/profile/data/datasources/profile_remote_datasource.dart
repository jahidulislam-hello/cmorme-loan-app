import 'package:logger/logger.dart';
import 'package:reverse_mortage_loan_app/core/constants/api_constants.dart';
import 'package:reverse_mortage_loan_app/core/services/api_service.dart';
import '../models/change_password_request_model.dart';
import '../models/change_password_response_model.dart';
import '../models/profile_model.dart';
import '../models/update_profile_request_model.dart';
import '../models/update_profile_response_model.dart';

class ProfileRemoteDatasource {
  final ApiService _apiService;
  final _logger = Logger();

  ProfileRemoteDatasource(this._apiService);

  Future<ProfileModel> getProfile() async {
    _logger.d('GetProfile request');
    final response = await _apiService.get(ApiConstants.myProfile);
    _logger.d('GetProfile raw response: ${response.data}');
    return ProfileModel.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  Future<UpdateProfileResponseModel> updateProfile(UpdateProfileRequestModel request) async {
    _logger.d('UpdateProfile request body: ${request.toJson()}');
    final response = await _apiService.post(
      ApiConstants.updateProfile,
      data: request.toJson(),
    );
    _logger.d('UpdateProfile raw response: ${response.data}');
    return UpdateProfileResponseModel.fromJson(response.data);
  }

  Future<ChangePasswordResponseModel> changePassword(ChangePasswordRequestModel request) async {
    _logger.d('ChangePassword request body: ${request.toJson()}');
    final response = await _apiService.post(
      ApiConstants.changePassword,
      data: request.toJson(),
    );
    _logger.d('ChangePassword raw response: ${response.data}');
    return ChangePasswordResponseModel.fromJson(response.data);
  }

  Future<void> deleteAccount(String id) async {
    _logger.d('DeleteAccount request — userId: $id');
    final response = await _apiService.delete('${ApiConstants.deleteAccount}/$id');
    _logger.d('DeleteAccount raw response: ${response.data}');
  }
}
