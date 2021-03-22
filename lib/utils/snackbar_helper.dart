import 'package:flutter/services.dart';

class SnackBarHelper {
  static const platform = MethodChannel('net.mylocalstore.my_localstore/toast');

  static Future<void> show(String title, String message,
      {isLong = false}) async {
    await platform
        .invokeMethod('toast', {"message": message,"title":title, "isLong": isLong});
  }
  // static void show(String title, String message) {
  //   Get.snackbar(title, message,
  //       snackPosition: SnackPosition.BOTTOM,
  //       snackStyle: SnackStyle.FLOATING,
  //       borderRadius: 6,
  //       // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //       margin: const EdgeInsets.all(12),
  //       backgroundColor: const Color(0xFF171717),
  //       colorText: Colors.white,
  //       animationDuration: const Duration(milliseconds: 300));
  // }
}
