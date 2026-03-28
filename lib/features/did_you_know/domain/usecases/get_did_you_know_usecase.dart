import 'package:reverse_mortage_loan_app/features/did_you_know/domain/repositories/did_you_know_repository.dart';

class GetDidYouKnowUseCase {
  final DidYouKnowRepository _repository;

  GetDidYouKnowUseCase(this._repository);

  Future<List<String>> call() async {
    return await _repository.getDidYouKnow();
  }
}
