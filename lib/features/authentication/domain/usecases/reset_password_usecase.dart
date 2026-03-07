import 'package:reverse_mortage_loan_app/features/authentication/data/models/reset_password_request_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/reset_password_response_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/domain/repositories/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository _repository;

  ResetPasswordUseCase(this._repository);

  Future<ResetPasswordResponseModel> call(ResetPasswordRequestModel request) {
    return _repository.resetPassword(request);
  }
}
