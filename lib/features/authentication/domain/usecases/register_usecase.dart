import 'package:reverse_mortage_loan_app/features/authentication/data/models/register_request_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/models/register_response_model.dart';
import 'package:reverse_mortage_loan_app/features/authentication/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  Future<RegisterResponseModel> call(RegisterRequestModel request) {
    return _repository.register(request);
  }
}
