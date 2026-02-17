import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/features/notification/presentation/view/controller/notification_controller.dart';
import 'package:reverse_mortage_loan_app/features/notification/presentation/view/widgets/notification_tile.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: AppColors.white, size: 30),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: const Text(
          'Notification',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: 16),
            const Text(
              'Today',
              style: TextStyle(
                color: AppColors.blue300,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...controller.todayNotifications.map(
              (item) => NotificationTile(
                title: item.title,
                time: item.time,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Yesterday',
              style: TextStyle(
                color: AppColors.blue300,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...controller.yesterdayNotifications.map(
              (item) => NotificationTile(
                title: item.title,
                time: item.time,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
