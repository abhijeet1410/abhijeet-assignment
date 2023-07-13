import 'package:assignment_pay/data_models/user.dart';
import 'package:assignment_pay/pages/authenticaton/basic_details/basic_details.dart';
import 'package:flutter/material.dart';
import 'package:assignment_pay/widgets/app_buttons/app_primary_button.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  String? _password, _confirmPassword, email;
  var isNewPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;
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
    Map<String, dynamic> _args = Get.arguments ?? {};
    email = _args['email'];
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
    return null;
  }

  String? confirmPasswordValidator(String? value, BuildContext context) {
    if (value == null || value.trim().isEmpty) {
      return "Field can't be blank";
    }
    if (_password?.trim() != value.trim()) {
      return 'Passwords mismatch';
    }
    return null;
  }

  void onPasswordSaved(String? newValue) {
    _password = newValue!.trim();
  }

  void onConfirmPasswordSaved(String? newValue) {
    _confirmPassword = newValue!.trim();
    validated = _password?.trim() == _confirmPassword?.trim();
    update([0]);
  }

  void onEmailSaved(String? newValue) {
    email = newValue!.trim();
  }

  void updatePassword() {
    final state = formKey.currentState;
    if (state == null) return;
    if (!state.validate()) {
      autoValidateMode.value = AutovalidateMode.always;
    } else {
      state.save();
      // Get.key.currentState!.push(VepayLoader());
      User onBoardingUser = User(email: email, password: _password, id: '123');
      Get.toNamed(BasicDetailsPage.routeName,
          arguments: {'onBoardingUser': onBoardingUser});
      // buttonKey.currentState?.showLoader();
      // AuthHelper.createPassword(_password).then((value) {
      //   Get.toNamed(ForgotPasswordChangedPage.routeName);
      // }).catchError((e, s) {
      //   SnackBarHelper.show(e.toString());
      // }).whenComplete(() => buttonKey.currentState?.hideLoader());
    }
  }
}
