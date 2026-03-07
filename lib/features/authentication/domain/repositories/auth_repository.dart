import 'package:reverse_mortage_loan_app/features/authentication/data/models/forget_password_request_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/forget_password_response_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/login_request_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/login_response_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/register_request_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/register_response_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/reset_password_request_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/reset_password_response_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/verify_forget_otp_response_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/verify_otp_request_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/verify_otp_response_model.dart';

abstract class AuthRepository {
  Future<RegisterResponseModel> register(RegisterRequestModel request);
  Future<VerifyOtpResponseModel> verifyOtp(VerifyOtpRequestModel request);
  Future<LoginResponseModel> login(LoginRequestModel request);
  Future<ForgetPasswordResponseModel> forgetPassword(ForgetPasswordRequestModel request);
  Future<VerifyForgetOtpResponseModel> verifyForgetOtp(VerifyOtpRequestModel request);
  Future<ResetPasswordResponseModel> resetPassword(ResetPasswordRequestModel request);
}
