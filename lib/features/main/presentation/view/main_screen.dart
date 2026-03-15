import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/features/history/presentation/view/page/history_screen.dart';
import 'package:reverse_mortage_loan_app/features/home/presentation/view/user_home_screen.dart';
import 'package:reverse_mortage_loan_app/features/main/presentation/view/controller/main_controller.dart';
import 'package:reverse_mortage_loan_app/features/profile/presentation/view/page/account_setting_screen.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_bottom_nav_bar.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          _TabViewWidget(child: UserHomeScreen()),
          _TabViewWidget(child: HistoryScreen()),
          _TabViewWidget(child: AccountSettingScreen()),
        ],
      ),
      bottomNavigationBar: Obx(() => CustomBottomNavBar(
            selectedIndex: controller.selectedIndex.value,
            onTap: controller.onNavTap,
          )),
    );
  }
}

class _TabViewWidget extends StatefulWidget {
  final Widget child;
  const _TabViewWidget({required this.child});

  @override
  State<_TabViewWidget> createState() => _TabViewWidgetState();
}

class _TabViewWidgetState extends State<_TabViewWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
