import 'package:logger/logger.dart';
import 'package:reverse_mortage_loan_app/core/constants/api_constants.dart';
import 'package:reverse_mortage_loan_app/core/services/api_service.dart';
import '../models/notification_model.dart';

class NotificationRemoteDatasource {
  final ApiService _apiService;
  final _logger = Logger();

  NotificationRemoteDatasource(this._apiService);

  Future<List<NotificationModel>> getNotifications() async {
    final response = await _apiService.get(ApiConstants.myNotifications);
    _logger.d('Notifications raw response: ${response.data}');
    final data = response.data['data'] as List;
    return data
        .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
