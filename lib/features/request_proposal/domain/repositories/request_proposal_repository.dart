import 'package:reverse_mortage_loan_app/features/request_proposal/data/models/my_proposal_response_model.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/data/models/request_proposal_request_model.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/data/models/request_proposal_response_model.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/data/models/update_proposal_request_model.dart';

abstract class RequestProposalRepository {
  Future<MyProposalResponseModel?> getMyProposal();
  Future<RequestProposalResponseModel> createProposal(
      RequestProposalRequestModel request);
  Future<void> updateProposal(String id, UpdateProposalRequestModel request);
}
