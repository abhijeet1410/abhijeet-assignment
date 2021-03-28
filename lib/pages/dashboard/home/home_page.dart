import 'package:flutter/material.dart';
import 'package:flutter_mobile_template/global_controllers/user_controller.dart';
import 'package:flutter_mobile_template/pages/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter_mobile_template/utils/notification_services/in_app_notification.dart';
import 'package:flutter_mobile_template/widgets/alert_sheet.dart';
import 'package:flutter_mobile_template/widgets/app_buttons/app_primary_button.dart';
import 'package:get/get.dart';

///
/// Created by Kumar Sunil from Boiler plate
///
class HomePage extends GetView<UserController> {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          controller.obx(
            (state) => ListTile(
              title: Text('${state?.name}'),
              subtitle: Text('${state?.email}'),
            ),
          ),
          Center(
            child: AppPrimaryButton(
                child: Text('Show in app notification'),
                onPressed: () {
                  InAppNotification.showNotification(
                      title: 'Demo',
                      description: 'Demo notification',
                      data: '1234');
                }),
          ),
          Center(
            child: AppPrimaryButton(
                child: Text('Go to Explore'),
                onPressed: () {
                  final dashboardController = Get.find<DashboardController>();
                  dashboardController.onTapBottomNav(1);
                }),
          ),
          Center(
            child: AppPrimaryButton(
                child: Text('Bottom sheet'),
                onPressed: () {
                  Get.bottomSheet(
                    AlertSheet(
                      title: 'Title',
                      description: 'Description',
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
