import 'package:flutter/material.dart';
import 'package:flutter_mobile_template/pages/authenticaton/pages/login/login_page.dart';
import 'package:flutter_mobile_template/utils/snackbar_helper.dart';
import 'package:flutter_mobile_template/widgets/app_buttons/app_primary_button.dart';
import 'package:get/get.dart';

///
/// Created by Kumar Sunil from Boiler plate
///
class UpdatePasswordController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<AppPrimaryButtonState> buttonKey = GlobalKey();
  late Rx<AutovalidateMode> autoValidateMode;
  late String _user, _token;
  String? _password;
  String? _confirmPassword;

  @override
  void onInit() {
    super.onInit();
    autoValidateMode = Rx<AutovalidateMode>(AutovalidateMode.disabled);
    autoValidateMode.value = AutovalidateMode.always;
    Map<String, dynamic> map = Get.arguments as Map<String, dynamic>;
    _user = map['user'];
    _token = map['token'];
  }

  @override
  void dispose() {
    autoValidateMode.close();
    super.dispose();
  }

  void onPasswordSaved(String? newValue) {
    _password = newValue!.trim();
  }

  String? passwordValidator(String? value) {
    _password = value!.trim();
    if (_password!.isEmpty) {
      return '*required';
    } else if (_password!.length < 8) {
      return "Password must be at least 8 chars long.";
    }
    return null;
  }

  void onConfirmPasswordSaved(String? newValue) {
    _confirmPassword = newValue!.trim();
  }

  String? confirmValidator(String? value) {
    _confirmPassword = value!.trim();
    if (value.trim().isEmpty) {
      return '*required';
    } else if (_password != _confirmPassword) {
      return "Passwords must be same.";
    }
    return null;
  }

  void updatePassword(BuildContext context) {
    // final state = _formKey.currentState;
    // if (!state.validate()) {
    //   setState(() {
    //     _autoValidate = true;
    //   });
    // } else {
    //   state.save();

    //   _buttonKey.currentState.showLoader();
    //   AuthHelper.changePassword(_confirmPassword, _user, _token).then((value) {
    Navigator.popUntil(
        context, (route) => route.settings.name == LoginPage.routeName);
    SnackBarHelper.show("Success", "Password reset successfully.");
    //   }).catchError((err, s) {
    //     log("ERROR " + err.toString(), stackTrace: s);
    //     SnackBarHelper.show("Error", err.toString());
    //   }).whenComplete(() => _buttonKey.currentState.hideLoader());
    // }
  }
}
