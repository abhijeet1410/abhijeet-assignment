import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_health/data_models/user.dart';
import 'package:pro_health/widgets/app_buttons/app_primary_button.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class ForgotPasswordVerificationController extends GetxController {
  String? phone, _code;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  late Rx<AutovalidateMode> autoValidateMode;
  late UserResponse user;

  @override
  void onInit() {
    super.onInit();
    autoValidateMode = Rx<AutovalidateMode>(AutovalidateMode.disabled);
    final map = Get.arguments as Map<String, dynamic>?;
    if (map != null) {
      user = map["data"];
      phone = map["phone"];
    }
  }

  @override
  void dispose() {
    autoValidateMode.close();
    super.dispose();
  }

  String? codeValidator(String? value, BuildContext context) {
    if (value == null || value.trim().isEmpty) {
      return '*required';
    }
  }

  void onCodeSaved(String? newValue) {
    _code = newValue!.trim();
  }

  void verifyPhoneNumber() {
    final state = formKey.currentState;
    if (state == null) return;
    if (!state.validate()) {
      autoValidateMode.value = AutovalidateMode.always;
    } else {
      state.save();
      // buttonKey.currentState?.showLoader();
      // AuthHelper.verifyRegisterOtp(_code).then((value) {
      //   Get.toNamed(ForgotPasswordUpdatePage.routeName);
      // }).catchError((e, s) {
      //   SnackBarHelper.show(e.toString());
      // }).whenComplete(() => buttonKey.currentState?.hideLoader());
    }
  }

  void resendOtp() async {
    // try {
    //   await AuthHelper.sendResendOtp(type: "forgotpassword");
    // } catch (e) {
    //   SnackBarHelper.show(e.toString());
    // }
  }
}
