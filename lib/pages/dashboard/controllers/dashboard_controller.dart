import 'dart:async';
import 'package:assignment_pay/pages/dashboard/home/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:assignment_pay/global_controllers/user_controller.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxInt selectedIndex = RxInt(0);
  late List _pages;
  RxBool forceSearch = RxBool(false);
  HomePage _homePage = HomePage();
  UserController controller = Get.find<UserController>();
  Widget get currentPage => _pages[selectedIndex.value];
  bool cameFromHome = false;

  @override
  void dispose() {
    forceSearch.close();
    super.dispose();
  }

  @override
  void onInit() {
    super.onInit();

    _pages = [
      HomePage(),
      Container(),
      Container(),
    ];
  }

  Future<bool> onPopScope() async {
    if (selectedIndex.value == 0)
      return true;
    else {
      selectedIndex.value = 0;
      return false;
    }
  }

  void onTap(int value) {
    selectedIndex.value = value;
  }

  void onTapView(bool val) {
    cameFromHome = val;
    update();
  }
}
