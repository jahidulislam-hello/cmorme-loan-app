import 'package:reverse_mortage_loan_app/features/profile/data/models/profile_model.dart';
import 'package:reverse_mortage_loan_app/features/profile/domain/repositories/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository _repository;

  GetProfileUseCase(this._repository);

  Future<ProfileModel> call() {
    return _repository.getProfile();
  }
}
