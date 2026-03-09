import 'package:reverse_mortage_loan_app/features/request_proposal/data/models/update_proposal_request_model.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/domain/repositories/request_proposal_repository.dart';

class UpdateProposalUseCase {
  final RequestProposalRepository _repository;

  UpdateProposalUseCase(this._repository);

  Future<void> call(String id, UpdateProposalRequestModel request) {
    return _repository.updateProposal(id, request);
  }
}
