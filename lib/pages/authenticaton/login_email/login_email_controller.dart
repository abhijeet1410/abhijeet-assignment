import 'package:assignment_pay/pages/dashboard/dashboard_page.dart';
import 'package:assignment_pay/utils/shared_preference_helper.dart';
import 'package:assignment_pay/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:assignment_pay/widgets/app_buttons/app_primary_button.dart';
import 'package:get/get.dart';

class LoginEmailController extends GetxController {
  String? _email, _password;

  RxBool isPasswordhidden = RxBool(true);

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

  void onEmailSaved(String? newValue) {
    _email = newValue!.trim();
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
        if (SharedPreferenceHelper.user!.user!.email == _email &&
            SharedPreferenceHelper.user!.user!.password == _password) {
          Get.offAllNamed(DashboardPage.routeName);
          SharedPreferenceHelper.logout(false);
        } else {
          SnackBarHelper.show("Invalid username or password");
        }
      }
    }
  }

  void updateObsecure() {
    isPasswordhidden.value = !isPasswordhidden.value;
  }
}
