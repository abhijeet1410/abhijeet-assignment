import 'package:flutter/material.dart';
import 'package:flutter_mobile_template/pages/dashboard/explore/explore_page.dart';
import 'package:flutter_mobile_template/pages/dashboard/home/home_page.dart';
import 'package:flutter_mobile_template/pages/dashboard/profile/profile_page.dart';
import 'package:get/get.dart';

///
/// Created by Kumar Sunil from Boiler plate
///
class DashboardController extends GetxController {
  late RxInt bottomNavIndex;
  final List<Widget> children = [
    HomePage(),
    ExplorePage(),
    ProfilePage(),
  ];

  Widget get currentBody => children[bottomNavIndex.value];

  @override
  void onInit() {
    bottomNavIndex = RxInt(0);
    super.onInit();
  }

  @override
  void dispose() {
    bottomNavIndex.close();
    super.dispose();
  }

  void onTapBottomNav(int value) {
    bottomNavIndex.value = value;
  }

  Future<bool> willPop() async {
    if (bottomNavIndex.value == 0)
      return true;
    else {
      onTapBottomNav(0);
      return false;
    }
  }
}
