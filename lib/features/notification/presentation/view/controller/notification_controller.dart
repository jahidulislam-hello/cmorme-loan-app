import 'package:get/get.dart';

class NotificationItem {
  final String title;
  final String time;

  const NotificationItem({required this.title, required this.time});
}

class NotificationController extends GetxController {
  final todayNotifications = const [
    NotificationItem(
      title: 'Govt reverse mortgage rate reduce to 4.5%',
      time: '11.00 AM',
    ),
    NotificationItem(
      title: 'Govt reverse mortgage rate reduce to 4.5%',
      time: '11.00 AM',
    ),
    NotificationItem(
      title: 'Govt reverse mortgage rate reduce to 4.5%',
      time: '11.00 AM',
    ),
  ];

  final yesterdayNotifications = const [
    NotificationItem(
      title: 'Govt reverse mortgage rate reduce to 4.5%',
      time: '11.00 AM',
    ),
    NotificationItem(
      title: 'Govt reverse mortgage rate reduce to 4.5%',
      time: '11.00 AM',
    ),
    NotificationItem(
      title: 'Govt reverse mortgage rate reduce to 4.5%',
      time: '11.00 AM',
    ),
  ];
}
