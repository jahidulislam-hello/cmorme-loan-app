import 'package:logger/logger.dart';
import 'package:reverse_mortage_loan_app/core/constants/api_constants.dart';
import 'package:reverse_mortage_loan_app/core/services/api_service.dart';
import '../models/my_proposal_response_model.dart';
import '../models/request_proposal_request_model.dart';
import '../models/request_proposal_response_model.dart';
import '../models/update_proposal_request_model.dart';

class RequestProposalRemoteDatasource {
  final ApiService _apiService;
  final _logger = Logger();

  RequestProposalRemoteDatasource(this._apiService);

  Future<RequestProposalResponseModel> createProposal(
      RequestProposalRequestModel request) async {
    _logger.d('CreateProposal request: ${request.toJson()}');
    final response = await _apiService.post(
      ApiConstants.requestProposalCreate,
      data: request.toJson(),
    );
    _logger.d('CreateProposal raw response: ${response.data}');
    return RequestProposalResponseModel.fromJson(
        response.data as Map<String, dynamic>);
  }

  Future<MyProposalResponseModel?> getMyProposal() async {
    _logger.d('GetMyProposal request: isCompleted=false');
    final response = await _apiService.get(
      ApiConstants.requestProposalMy,
      queryParameters: {'isCompleted': false},
    );
    _logger.d('GetMyProposal raw response: ${response.data}');
    final body = response.data as Map<String, dynamic>;
    if (body['data'] == null) return null;
    return MyProposalResponseModel.fromJson(body);
  }

  Future<void> updateProposal(
      String id, UpdateProposalRequestModel request) async {
    _logger.d('UpdateProposal id=$id request: ${request.toJson()}');
    final response = await _apiService.patch(
      '${ApiConstants.requestProposalUpdate}/$id',
      data: request.toJson(),
    );
    _logger.d('UpdateProposal raw response: ${response.data}');
  }
}
