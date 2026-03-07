import 'package:reverse_mortage_loan_app/features/authentication/data/models/forget_password_request_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/forget_password_response_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/domain/repositories/auth_repository.dart';

class ForgetPasswordUseCase {
  final AuthRepository _repository;

  ForgetPasswordUseCase(this._repository);

  Future<ForgetPasswordResponseModel> call(ForgetPasswordRequestModel request) {
    return _repository.forgetPassword(request);
  }
}
