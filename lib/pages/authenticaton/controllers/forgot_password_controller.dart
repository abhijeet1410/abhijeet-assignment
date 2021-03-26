import 'package:flutter/material.dart';
import 'package:flutter_mobile_template/pages/authenticaton/pages/reset_password/forgot_password_option_page.dart';
import 'package:flutter_mobile_template/widgets/app_buttons/app_primary_button.dart';
import 'package:get/get.dart';

///
/// Created by Kumar Sunil from Boiler plate
///
class ForgotPasswordController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<AppPrimaryButtonState> buttonKey = GlobalKey();
  late Rx<AutovalidateMode> autoValidateMode;
  String? _field;

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

  String? emailValidator(String? value, BuildContext context) {
    if (value == null || value.trim().isEmpty) {
      return '*required';
    } else if (!GetUtils.isEmail(value.trim()) &&
        !GetUtils.isPhoneNumber(value.trim())) {
      return 'Not a valid email address or phone.';
    }
    return null;
  }

  void onFieldSaved(String? newValue) {
    _field = newValue!.trim();
  }

  void checkUser() {
    final state = formKey.currentState;
    if (state == null) return;
    if (!state.validate()) {
      autoValidateMode.value = AutovalidateMode.always;
    } else {
      state.save();
      Get.toNamed(ForgotPasswordOptionPage.routeName,
          arguments: {'email': _field, 'phone': _field, "userId": '1234'});
      //   _buttonKey.currentState.showLoader();
      //   AuthHelper.checkForgotUser(_field).then((value) {
      //     Get.toNamed(ForgotPasswordOptionPage.routeName, arguments: value);
      //   }).catchError((err, s) {
      //     SnackBarHelper.show('Error', '$err');
      //   }).whenComplete(() => {_buttonKey.currentState.hideLoader()});
    }
  }
}
