import 'package:reverse_mortage_loan_app/features/authentication/data/models/resend_otp_response_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/domain/repositories/auth_repository.dart';

class ResendOtpUseCase {
  final AuthRepository _repository;

  ResendOtpUseCase(this._repository);

  Future<ResendOtpResponseModel> call(String email) {
    return _repository.resendOtp(email);
  }
}
