import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_health/widgets/app_buttons/app_primary_button.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class LoginPhoneController extends GetxController {
  String? _phone;

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

  void onPhoneSaved(String? newValue) {
    _phone = newValue!.trim();
  }

  void loginPhoneNumber() {
    final state = formKey.currentState;
    if (state == null) return;
    if (!state.validate()) {
      autoValidateMode.value = AutovalidateMode.always;
    } else {
      state.save();
      // buttonKey.currentState?.showLoader();
      //
      // AuthHelper.loginWithPhonePassword(_phone, _password).then((value) {
      //   AuthHelper.checkUserLevel();
      // }).catchError((e, s) {
      //   SnackBarHelper.show(e.toString());
      // }).whenComplete(() => buttonKey.currentState?.hideLoader());
    }
  }
}