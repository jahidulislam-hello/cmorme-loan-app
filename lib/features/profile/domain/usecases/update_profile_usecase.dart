import 'package:reverse_mortage_loan_app/features/profile/data/models/update_profile_request_model.dart';
import 'package:reverse_mortage_loan_app/features/profile/data/models/update_profile_response_model.dart';
import 'package:reverse_mortage_loan_app/features/profile/domain/repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository _repository;

  UpdateProfileUseCase(this._repository);

  Future<UpdateProfileResponseModel> call(UpdateProfileRequestModel request) {
    return _repository.updateProfile(request);
  }
}
