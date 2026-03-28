import 'package:logger/logger.dart';
import 'package:reverse_mortage_loan_app/core/constants/api_constants.dart';
import 'package:reverse_mortage_loan_app/core/services/api_service.dart';
import '../models/did_you_know_response_model.dart';

class DidYouKnowRemoteDatasource {
  final ApiService _apiService;
  final _logger = Logger();

  DidYouKnowRemoteDatasource(this._apiService);

  Future<DidYouKnowResponseModel> getDidYouKnow() async {
    _logger.d('GetDidYouKnow: fetching tips');
    final response = await _apiService.get(ApiConstants.didYouKnowAll);
    _logger.d('GetDidYouKnow raw response: ${response.data}');
    return DidYouKnowResponseModel.fromJson(response.data as Map<String, dynamic>);
  }
}
