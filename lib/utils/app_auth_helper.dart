import 'dart:developer';

import 'package:assignment_pay/api_services/base_api.dart';
import 'package:assignment_pay/app_configs/api_routes.dart';
import 'package:assignment_pay/data_models/user.dart';
import 'package:assignment_pay/global_controllers/user_controller.dart';
import 'package:assignment_pay/pages/authenticaton/login_email/login_email_page.dart';
import 'package:assignment_pay/pages/dashboard/dashboard_page.dart';
import 'package:assignment_pay/pages/lock_screen/lock_screen.dart';
import 'package:assignment_pay/utils/shared_preference_helper.dart';
import 'package:get/get.dart';

import 'snackbar_helper.dart';

class AuthHelper {

  ///
  /// Checks the user on-boarding
  ///
  static Future<void> checkUserLevel(
      {String? parentPath, String? phone}) async {
    final UserResponse? user = SharedPreferenceHelper.user;
    final userController = Get.isRegistered()
        ? Get.find<UserController>()
        : Get.put<UserController>(UserController(), permanent: true);
    if (user != null) {
      Get.offAllNamed(LockScreen.routeName);
    } else {
      Get.offAllNamed(LoginEmailPage.routeName);
    }
  }
}
