import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobile_template/data_models/social_signin_response.dart';
import 'package:flutter_mobile_template/data_models/user.dart';
import 'package:flutter_mobile_template/global_controllers/user_controller.dart';
import 'package:flutter_mobile_template/pages/authenticaton/pages/register/register_page.dart';
import 'package:flutter_mobile_template/pages/dashboard/dashboard_page.dart';
import 'package:flutter_mobile_template/utils/app_auth_helper.dart';
import 'package:flutter_mobile_template/widgets/app_buttons/app_primary_button.dart';
import 'package:flutter_mobile_template/widgets/app_loader.dart';
import 'package:get/get.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class LoginController extends GetxController {
  late RxBool isObscure;
  String _emailId = '', _password = '';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  late Rx<AutovalidateMode> autoValidateMode;

  @override
  void onInit() {
    super.onInit();
    isObscure = RxBool(false);
    autoValidateMode = Rx<AutovalidateMode>(AutovalidateMode.disabled);
  }

  @override
  void dispose() {
    isObscure.close();
    autoValidateMode.close();
    super.dispose();
  }

  String? emailValidator(String? value, BuildContext context) {
    if (value == null || value.trim().isEmpty) {
      return '*required';
    } else {
      if (!GetUtils.isEmail(value.trim())) {
        return 'Not a valid email id.';
      }
    }
  }

  void onEmailSaved(String? newValue) {
    _emailId = newValue!.trim();
  }

  String? passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '*required';
    }
    return null;
  }

  void onPasswordSaved(String? newValue) {
    _password = newValue!.trim();
  }

  void toggleObscure() {
    isObscure.value = !(isObscure.value);
  }

  void loginEmailAddress() {
    final state = formKey.currentState;
    if (state == null) return;
    if (!state.validate()) {
      autoValidateMode.value = AutovalidateMode.always;
    } else {
      state.save();
      final userController = Get.find<UserController>();
      userController.updateUser(UserDatum(
          id: '12',
          status: 1,
          email: 'a@a.com',
          phone: '123456',
          name: 'Sunil'));
      Get.toNamed(DashboardPage.routeName);
      // buttonKey.currentState?.showLoader();
      // AuthHelper.userLoginWithEmailOrPhone(_emailId, _password)
      //     .then((response) {})
      //     .catchError((err, s) {
      //   log('$err $s');
      //   if (err is RestError) {
      //     if (err.code == 425) {
      //       SnackBarHelper.show('New User', 'Please sign up to continue');
      //       Get.toNamed(RegisterPage.routeName,
      //           arguments: {"email": _emailId, "password": _password});
      //     } else {
      //       SnackBarHelper.show('Error', '$err');
      //     }
      //   } else {
      //     SnackBarHelper.show('Error', '$err');
      //   }
      // }).whenComplete(() => {buttonKey.currentState?.hideLoader()});
    }
  }

  void socialSignIn(int type) async {
    Get.key!.currentState!.push(LoaderOverlay());
    try {
      SocialSignInResponse? user;
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
        Get.offAndToNamed(RegisterPage.routeName,
            arguments: {"email": user.email, "name": user.name});
      }
    } catch (err, s) {
      Get.key!.currentState!.pop();
      log('$err $s');
      // SnackBarHelper.show('Error', '$err');
    }
  }
}
