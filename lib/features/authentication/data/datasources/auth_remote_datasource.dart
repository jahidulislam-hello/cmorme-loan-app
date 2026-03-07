import 'package:logger/logger.dart';
import 'package:reverse_mortage_loan_app/core/constants/api_constants.dart';
import 'package:reverse_mortage_loan_app/core/services/api_service.dart';
import '../models/forget_password_request_model.dart';
import '../models/forget_password_response_model.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';
import '../models/register_request_model.dart';
import '../models/register_response_model.dart';
import '../models/reset_password_request_model.dart';
import '../models/reset_password_response_model.dart';
import '../models/verify_forget_otp_response_model.dart';
import '../models/verify_otp_request_model.dart';
import '../models/verify_otp_response_model.dart';

class AuthRemoteDatasource {
  final ApiService _apiService;
  final _logger = Logger();

  AuthRemoteDatasource(this._apiService);

  Future<RegisterResponseModel> register(RegisterRequestModel request) async {
    _logger.d('Register request body: ${request.toJson()}');
    final response = await _apiService.post(
      ApiConstants.register,
      data: request.toJson(),
    );
    _logger.d('Register raw response: ${response.data}');
    return RegisterResponseModel.fromJson(response.data);
  }

  Future<VerifyOtpResponseModel> verifyOtp(VerifyOtpRequestModel request) async {
    _logger.d('VerifyOtp request body: ${request.toJson()}');
    final response = await _apiService.post(
      ApiConstants.verifyOtp,
      data: request.toJson(),
    );
    _logger.d('VerifyOtp raw response: ${response.data}');
    return VerifyOtpResponseModel.fromJson(response.data);
  }

  Future<LoginResponseModel> login(LoginRequestModel request) async {
    _logger.d('Login request body: ${request.toJson()}');
    final response = await _apiService.post(
      ApiConstants.login,
      data: request.toJson(),
    );
    _logger.d('Login raw response: ${response.data}');
    return LoginResponseModel.fromJson(response.data);
  }

  Future<ForgetPasswordResponseModel> forgetPassword(ForgetPasswordRequestModel request) async {
    _logger.d('ForgetPassword request body: ${request.toJson()}');
    final response = await _apiService.post(
      ApiConstants.forgetPassword,
      data: request.toJson(),
    );
    _logger.d('ForgetPassword raw response: ${response.data}');
    return ForgetPasswordResponseModel.fromJson(response.data);
  }

  Future<VerifyForgetOtpResponseModel> verifyForgetOtp(VerifyOtpRequestModel request) async {
    _logger.d('VerifyForgetOtp request body: ${request.toJson()}');
    final response = await _apiService.post(
      ApiConstants.verifyForgetOtp,
      data: request.toJson(),
    );
    _logger.d('VerifyForgetOtp raw response: ${response.data}');
    return VerifyForgetOtpResponseModel.fromJson(response.data);
  }

  Future<ResetPasswordResponseModel> resetPassword(ResetPasswordRequestModel request) async {
    _logger.d('ResetPassword request body: ${request.toJson()}');
    final response = await _apiService.post(
      ApiConstants.resetPassword,
      data: request.toJson(),
    );
    _logger.d('ResetPassword raw response: ${response.data}');
    return ResetPasswordResponseModel.fromJson(response.data);
  }
}
