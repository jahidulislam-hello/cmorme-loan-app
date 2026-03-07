import 'package:reverse_mortage_loan_app/features/profile/data/models/change_password_request_model.dart';
import 'package:reverse_mortage_loan_app/features/profile/data/models/change_password_response_model.dart';
import 'package:reverse_mortage_loan_app/features/profile/domain/repositories/profile_repository.dart';

class ChangePasswordUseCase {
  final ProfileRepository _repository;

  ChangePasswordUseCase(this._repository);

  Future<ChangePasswordResponseModel> call(ChangePasswordRequestModel request) {
    return _repository.changePassword(request);
  }
}
