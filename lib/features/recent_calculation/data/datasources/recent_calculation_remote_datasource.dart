import 'package:logger/logger.dart';
import 'package:reverse_mortage_loan_app/core/constants/api_constants.dart';
import 'package:reverse_mortage_loan_app/core/services/api_service.dart';
import '../models/recent_calculation_response_model.dart';

class RecentCalculationRemoteDatasource {
  final ApiService _apiService;
  final _logger = Logger();

  RecentCalculationRemoteDatasource(this._apiService);

  Future<RecentCalculationResponseModel> getCalculations({int limit = 10}) async {
    _logger.d('GetCalculations request: limit=$limit');
    final response = await _apiService.get(
      ApiConstants.calculateLoanAll,
      queryParameters: {'limit': limit},
    );
    _logger.d('GetCalculations raw response: ${response.data}');
    return RecentCalculationResponseModel.fromJson(
        response.data as Map<String, dynamic>);
  }

  Future<RecentCalculationItemModel> getCalculationById(String id) async {
    _logger.d('GetCalculationById request: id=$id');
    final response = await _apiService.get('${ApiConstants.calculateLoanById}/$id');
    _logger.d('GetCalculationById raw response: ${response.data}');
    return RecentCalculationItemModel.fromJson(
        response.data['data'] as Map<String, dynamic>);
  }

  Future<void> deleteCalculation(String id) async {
    _logger.d('DeleteCalculation request: id=$id');
    final response = await _apiService.delete(
      '${ApiConstants.calculateLoanDelete}/$id',
    );
    _logger.d('DeleteCalculation raw response: ${response.data}');
  }
}
