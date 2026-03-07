import 'package:reverse_mortage_loan_app/features/authentication/data/models/login_request_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/login_response_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<LoginResponseModel> call(LoginRequestModel request) {
    return _repository.login(request);
  }
}
