import 'package:reverse_mortage_loan_app/features/legal/data/models/legal_response_model.dart';
import 'package:reverse_mortage_loan_app/features/legal/domain/repositories/legal_repository.dart';

class GetLegalContentUseCase {
  final LegalRepository _repository;

  GetLegalContentUseCase(this._repository);

  Future<LegalResponseModel> call(String endpoint) =>
      _repository.getLegalContent(endpoint);
}
