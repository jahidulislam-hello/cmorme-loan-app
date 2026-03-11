import 'package:reverse_mortage_loan_app/core/services/token_service.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/forget_password_request_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/forget_password_response_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/login_request_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/login_response_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/register_request_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/register_response_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/reset_password_request_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/reset_password_response_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/resend_otp_response_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/verify_forget_otp_response_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/verify_otp_request_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/verify_otp_response_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _datasource;
  final TokenService _tokenService;

  AuthRepositoryImpl(this._datasource, this._tokenService);

  @override
  Future<RegisterResponseModel> register(RegisterRequestModel request) async {
    final response = await _datasource.register(request);
    await _tokenService.saveToken(response.token);
    return response;
  }

  @override
  Future<VerifyOtpResponseModel> verifyOtp(VerifyOtpRequestModel request) async {
    return await _datasource.verifyOtp(request);
  }

  @override
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    final response = await _datasource.login(request);
    await _tokenService.saveToken(response.token);
    return response;
  }

  @override
  Future<ForgetPasswordResponseModel> forgetPassword(ForgetPasswordRequestModel request) async {
    final response = await _datasource.forgetPassword(request);
    await _tokenService.saveToken(response.token);
    return response;
  }

  @override
  Future<VerifyForgetOtpResponseModel> verifyForgetOtp(VerifyOtpRequestModel request) async {
    final response = await _datasource.verifyForgetOtp(request);
    await _tokenService.saveToken(response.token);
    return response;
  }

  @override
  Future<ResetPasswordResponseModel> resetPassword(ResetPasswordRequestModel request) async {
    final response = await _datasource.resetPassword(request);
    await _tokenService.deleteToken();
    return response;
  }

  @override
  Future<ResendOtpResponseModel> resendOtp(String email) async {
    final response = await _datasource.resendOtp(email);
    await _tokenService.saveToken(response.token);
    return response;
  }
}
