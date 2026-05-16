import 'package:reverse_mortage_loan_app/features/profile/domain/repositories/profile_repository.dart';

class DeleteAccountUseCase {
  final ProfileRepository _repository;

  DeleteAccountUseCase(this._repository);

  Future<void> call(String id) {
    return _repository.deleteAccount(id);
  }
}
