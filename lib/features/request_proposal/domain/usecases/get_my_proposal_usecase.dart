import 'package:reverse_mortage_loan_app/features/request_proposal/data/models/my_proposal_response_model.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/domain/repositories/request_proposal_repository.dart';

class GetMyProposalUseCase {
  final RequestProposalRepository _repository;

  GetMyProposalUseCase(this._repository);

  Future<MyProposalResponseModel?> call() {
    return _repository.getMyProposal();
  }
}
