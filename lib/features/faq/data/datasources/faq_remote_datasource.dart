import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:reverse_mortage_loan_app/core/constants/api_constants.dart';
import 'package:reverse_mortage_loan_app/core/services/api_service.dart';
import 'package:reverse_mortage_loan_app/core/utils/isolate_parsers.dart';
import '../models/faq_response_model.dart';

class FaqRemoteDatasource {
  final ApiService _apiService;
  final _logger = Logger();

  FaqRemoteDatasource(this._apiService);

  Future<List<FaqItemModel>> getFaqs() async {
    _logger.d('GetFaqs: fetching ${ApiConstants.faqAll}');
    final response = await _apiService.get(ApiConstants.faqAll);
    _logger.d('GetFaqs raw response received');
    return compute(parseFaqs, response.data as Map<String, dynamic>);
  }
}
