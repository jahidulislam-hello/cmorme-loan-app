import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:reverse_mortage_loan_app/core/constants/api_constants.dart';
import 'package:reverse_mortage_loan_app/core/services/api_service.dart';
import 'package:reverse_mortage_loan_app/core/utils/isolate_parsers.dart';
import '../models/recent_calculation_response_model.dart';

class RecentCalculationRemoteDatasource {
  final ApiService _apiService;
  final _logger = Logger();

  RecentCalculationRemoteDatasource(this._apiService);

  Future<RecentCalculationResponseModel> getCalculations({int limit = 10, int page = 1}) async {
    _logger.d('GetCalculations request: limit=$limit, page=$page');
    final response = await _apiService.get(
      ApiConstants.calculateLoanAll,
      queryParameters: {'limit': limit, 'page': page},
    );
    _logger.d('GetCalculations raw response received');
    return compute(parseCalculationResponse, response.data as Map<String, dynamic>);
  }

  Future<RecentCalculationItemModel> getCalculationById(String id) async {
    _logger.d('GetCalculationById request: id=$id');
    final response = await _apiService.get('${ApiConstants.calculateLoanById}/$id');
    _logger.d('GetCalculationById raw response: ${response.data}');
    // Single object — compute() overhead exceeds parse time, not needed
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
