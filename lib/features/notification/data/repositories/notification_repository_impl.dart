import 'package:reverse_mortage_loan_app/features/notification/data/datasources/notification_remote_datasource.dart';
import 'package:reverse_mortage_loan_app/features/notification/data/models/notification_model.dart';
import 'package:reverse_mortage_loan_app/features/notification/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDatasource _datasource;

  NotificationRepositoryImpl(this._datasource);

  @override
  Future<List<NotificationModel>> getNotifications() =>
      _datasource.getNotifications();
}
