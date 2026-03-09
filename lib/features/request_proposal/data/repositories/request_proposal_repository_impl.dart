import 'package:reverse_mortage_loan_app/features/request_proposal/data/datasources/request_proposal_remote_datasource.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/data/models/my_proposal_response_model.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/data/models/request_proposal_request_model.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/data/models/request_proposal_response_model.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/data/models/update_proposal_request_model.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/domain/repositories/request_proposal_repository.dart';

class RequestProposalRepositoryImpl implements RequestProposalRepository {
  final RequestProposalRemoteDatasource _datasource;

  RequestProposalRepositoryImpl(this._datasource);

  @override
  Future<MyProposalResponseModel?> getMyProposal() {
    return _datasource.getMyProposal();
  }

  @override
  Future<RequestProposalResponseModel> createProposal(
      RequestProposalRequestModel request) {
    return _datasource.createProposal(request);
  }

  @override
  Future<void> updateProposal(String id, UpdateProposalRequestModel request) {
    return _datasource.updateProposal(id, request);
  }
}
