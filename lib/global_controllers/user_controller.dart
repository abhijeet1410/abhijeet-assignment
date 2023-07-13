import 'dart:developer';

import 'package:assignment_pay/api_services/base_api.dart';
import 'package:assignment_pay/app_configs/api_routes.dart';
import 'package:assignment_pay/data_models/user.dart';
import 'package:assignment_pay/utils/shared_preference_helper.dart';
import 'package:assignment_pay/utils/snackbar_helper.dart';
import 'package:get/get.dart';

class UserController extends GetxController with StateMixin<User> {
  @override
  void onInit() {
    super.onInit();

    final user = SharedPreferenceHelper.user?.user;
    change(user, status: user == null ? RxStatus.empty() : RxStatus.success());
  }

  updateUser(User? user) {
    final u = SharedPreferenceHelper.user;
    if (u != null) {
      u.user = user;
      SharedPreferenceHelper.storeUser(user: u);
    }
    change(null, status: RxStatus.loading());
    change(user, status: RxStatus.success());
  }
}
