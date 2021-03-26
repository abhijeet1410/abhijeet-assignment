import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/dashboard_controller.dart';

///
/// Created by Kumar Sunil from Boiler plate
///
class DashboardPage extends GetView<DashboardController> {
  static const routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: controller.willPop,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: controller.currentBody,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.explore), label: 'Explore'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
            onTap: controller.onTapBottomNav,
            currentIndex: controller.bottomNavIndex.value,
          ),
        ),
      ),
    );
  }
}
