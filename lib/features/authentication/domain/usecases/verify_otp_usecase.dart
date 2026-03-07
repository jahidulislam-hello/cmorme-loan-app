import 'package:reverse_mortage_loan_app/features/authentication/data/models/verify_otp_request_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/verify_otp_response_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/domain/repositories/auth_repository.dart';

class VerifyOtpUseCase {
  final AuthRepository _repository;

  VerifyOtpUseCase(this._repository);

  Future<VerifyOtpResponseModel> call(VerifyOtpRequestModel request) {
    return _repository.verifyOtp(request);
  }
}
