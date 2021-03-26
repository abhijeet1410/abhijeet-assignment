import 'package:flutter_mobile_template/data_models/user.dart';
import 'package:flutter_mobile_template/utils/shared_preference_helper.dart';
import 'package:get/get.dart';

///
/// Created by Kumar Sunil from Boiler plate
///
class UserController extends GetxController with StateMixin<UserDatum> {
  @override
  void onInit() {
    super.onInit();
  }

  void updateUser(UserDatum? user) {
    final u = SharedPreferenceHelper.user;
    if (u != null) {
      u.user = user;
      SharedPreferenceHelper.storeUser(user: u);
    }
    change(user, status: RxStatus.success());
  }
}
