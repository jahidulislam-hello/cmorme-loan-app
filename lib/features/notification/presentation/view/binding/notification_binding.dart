import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/core/services/api_service.dart';
import 'package:reverse_mortage_loan_app/features/notification/data/datasources/notification_remote_datasource.dart';
import 'package:reverse_mortage_loan_app/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:reverse_mortage_loan_app/features/notification/domain/repositories/notification_repository.dart';
import 'package:reverse_mortage_loan_app/features/notification/domain/usecases/get_notifications_usecase.dart';
import 'package:reverse_mortage_loan_app/features/notification/presentation/view/controller/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationRemoteDatasource>(
      () => NotificationRemoteDatasource(ApiService()),
    );
    Get.lazyPut<NotificationRepository>(
      () => NotificationRepositoryImpl(Get.find<NotificationRemoteDatasource>()),
    );
    Get.lazyPut<GetNotificationsUseCase>(
      () => GetNotificationsUseCase(Get.find<NotificationRepository>()),
    );
    Get.lazyPut<NotificationController>(
      () => NotificationController(Get.find<GetNotificationsUseCase>()),
    );
  }
}
