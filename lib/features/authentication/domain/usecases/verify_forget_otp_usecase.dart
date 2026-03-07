import 'package:reverse_mortage_loan_app/features/authentication/data/models/verify_otp_request_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/verify_forget_otp_response_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/domain/repositories/auth_repository.dart';

class VerifyForgetOtpUseCase {
  final AuthRepository _repository;

  VerifyForgetOtpUseCase(this._repository);

  Future<VerifyForgetOtpResponseModel> call(VerifyOtpRequestModel request) {
    return _repository.verifyForgetOtp(request);
  }
}
