import 'package:assignment_pay/pages/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:assignment_pay/utils/app_auth_helper.dart';
import 'package:assignment_pay/utils/snackbar_helper.dart';
import 'package:assignment_pay/widgets/app_buttons/app_primary_button.dart';
import 'package:get/get.dart';
import '../../../data_models/user.dart';
import '../../../utils/shared_preference_helper.dart';
import '../../authenticaton/login_email/login_email_page.dart';
import '../lock_screen.dart';

///
/// Created by Abhijeet Mohapatra
///
class LockScreenController extends GetxController {
  String? _password;
  RxBool isPasswordHidden = RxBool(true);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  late Rx<AutovalidateMode> autoValidateMode;

  @override
  void onInit() {
    super.onInit();
    autoValidateMode = Rx<AutovalidateMode>(AutovalidateMode.disabled);
  }

  @override
  void dispose() {
    autoValidateMode.close();
    super.dispose();
  }

  void onPasswordSaved(String? newValue) {
    _password = newValue!.trim();
  }

  void loginPhoneNumber() {
    final state = formKey.currentState;
    if (state == null) return;
    if (!state.validate()) {
      autoValidateMode.value = AutovalidateMode.always;
    } else {
      state.save();
    }
  }

  void onLogin() {
    final state = formKey.currentState;
    if (state == null) return;
    if (!state.validate()) {
      autoValidateMode.value = AutovalidateMode.always;
    } else {
      state.save();
      if (SharedPreferenceHelper.user == null) {
        SnackBarHelper.show("You must sign up to continue");
      } else {
        if (SharedPreferenceHelper.user!.user!.password == _password) {
          Get.offAllNamed(DashboardPage.routeName);
        } else {
          SnackBarHelper.show("Invalid username or password");
        }
      }
    }
  }

  void onRefreshAccessToken() {
    SharedPreferenceHelper.storeUser(user: SharedPreferenceHelper.user);
  }

  void updateObscure() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }
}
