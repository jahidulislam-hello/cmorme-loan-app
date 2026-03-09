import 'package:reverse_mortage_loan_app/features/request_proposal/data/models/request_proposal_request_model.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/data/models/request_proposal_response_model.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/domain/repositories/request_proposal_repository.dart';

class CreateProposalUseCase {
  final RequestProposalRepository _repository;

  CreateProposalUseCase(this._repository);

  Future<RequestProposalResponseModel> call(
      RequestProposalRequestModel request) {
    return _repository.createProposal(request);
  }
}
