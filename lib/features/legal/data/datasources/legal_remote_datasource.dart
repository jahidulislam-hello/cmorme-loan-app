import 'package:logger/logger.dart';
import 'package:reverse_mortage_loan_app/core/services/api_service.dart';
import 'package:reverse_mortage_loan_app/features/legal/data/models/legal_response_model.dart';

class LegalRemoteDatasource {
  final ApiService _apiService;
  final _logger = Logger();

  LegalRemoteDatasource(this._apiService);

  Future<LegalResponseModel> getLegalContent(String endpoint) async {
    _logger.i('GET $endpoint');
    final response = await _apiService.dio.get(endpoint);
    _logger.i('getLegalContent response: ${response.data}');
    return LegalResponseModel.fromJson(
      response.data['data'] as Map<String, dynamic>,
    );
  }
}
