import 'package:flutter/material.dart';
import 'package:assignment_pay/widgets/app_buttons/app_primary_button.dart';
import 'package:get/get.dart';

class ForgotPasswordUpdateController extends GetxController {
  String? _password, _confirmPassword;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  late Rx<AutovalidateMode> autoValidateMode;
  late bool validated;

  @override
  void onInit() {
    super.onInit();
    autoValidateMode = Rx<AutovalidateMode>(AutovalidateMode.disabled);
    validated = false;
  }

  @override
  void dispose() {
    autoValidateMode.close();
    super.dispose();
  }

  String? passwordValidator(String? value, BuildContext context) {
    if (value == null || value.trim().isEmpty) {
      return '*required';
    }
  }

  String? confirmPasswordValidator(String? value, BuildContext context) {
    if (value == null || value.trim().isEmpty) {
      return '*required';
    }
    if (_password?.trim() != value.trim()) {
      return '*Passwords mismatch';
    }
  }

  void onPasswordSaved(String? newValue) {
    _password = newValue!.trim();
  }

  void onConfirmPasswordSaved(String? newValue) {
    _confirmPassword = newValue!.trim();
    validated = _password?.trim() == _confirmPassword?.trim();
    update([0]);
  }

  void updatePassword() {
    final state = formKey.currentState;
    if (state == null) return;
    if (!state.validate()) {
      autoValidateMode.value = AutovalidateMode.always;
    } else {
      state.save();
      // buttonKey.currentState?.showLoader();
      // AuthHelper.createPassword(_password).then((value) {
      //   Get.toNamed(ForgotPasswordChangedPage.routeName);
      // }).catchError((e, s) {
      //   SnackBarHelper.show(e.toString());
      // }).whenComplete(() => buttonKey.currentState?.hideLoader());
    }
  }
}
