import 'dart:developer';

import 'package:ausicare_doctor/data_models/user.dart';
import 'package:ausicare_doctor/pages/authenticaton/pages/onboarding/otp_verification_page.dart';
import 'package:ausicare_doctor/utils/app_auth_helper.dart';
import 'package:ausicare_doctor/utils/snackbar_helper.dart';
import 'package:ausicare_doctor/widgets/app_buttons/app_primary_button.dart';
import 'package:ausicare_doctor/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class LoginController extends GetxController {
  String _phone = '';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  late Rx<AutovalidateMode> autoValidateMode;
  String? _parentPath;

  @override
  void onInit() {
    super.onInit();
    autoValidateMode = Rx<AutovalidateMode>(AutovalidateMode.disabled);
    final Map<String, dynamic>? map = Get.arguments as Map<String, dynamic>;
    if (map != null) {
      _parentPath = map['parent'];
    }
  }

  @override
  void dispose() {
    autoValidateMode.close();
    super.dispose();
  }

  String? phoneValidator(String? value, {BuildContext? context}) {
    if (value == null || value.trim().isEmpty) {
      return '*required';
    } else {
      if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value)) {
        return 'Not a valid phone number.';
      } else
        return null;
    }
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
      buttonKey.currentState?.showLoader();
      AuthHelper.userLoginWithPhone(_phone).then((value) {
        SnackBarHelper.show("", "OTP sent to $_phone}");
        Get.toNamed(OtpVerificationPage.routeName,
            arguments: {'phone': _phone, 'parent': _parentPath});
      }).catchError((e, s) {
        log("loginPhoneNumber", error: e, stackTrace: s);
        SnackBarHelper.show('', e.toString());
      }).whenComplete(() => buttonKey.currentState?.hideLoader());
    }
  }

  void socialSignIn(int type) async {
    Get.key.currentState!.push(LoaderOverlay());
    try {
      UserResponse? user;
      switch (type) {
        case 1:
          user = await AuthHelper.userLoginWithGoogle();
          break;

        case 2:
          user = await AuthHelper.userLoginWithFacebook();
          break;

        case 3:
          user = await AuthHelper.userLoginWithApple();
          break;
      }
      if (user != null) {
        AuthHelper.checkUserLevel();
      } else {
        Get.key.currentState!.pop();
      }
    } catch (err, s) {
      Get.key.currentState!.pop();
      log('$err $s');
    }
  }
}
