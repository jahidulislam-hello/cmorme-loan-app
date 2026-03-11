import 'package:reverse_mortage_loan_app/features/notification/data/models/notification_model.dart';
import 'package:reverse_mortage_loan_app/features/notification/domain/repositories/notification_repository.dart';

class GetNotificationsUseCase {
  final NotificationRepository _repository;

  GetNotificationsUseCase(this._repository);

  Future<List<NotificationModel>> call() => _repository.getNotifications();
}
