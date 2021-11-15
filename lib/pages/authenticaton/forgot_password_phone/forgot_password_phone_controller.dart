import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_health/widgets/app_buttons/app_primary_button.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class ForgotPasswordPhoneController extends GetxController {
  String? phone;
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
    phone = newValue!.trim();
  }

  void verifyPhoneNumber() {
    final state = formKey.currentState;
    if (state == null) return;
    if (!state.validate()) {
      autoValidateMode.value = AutovalidateMode.always;
    } else {
      state.save();
      // buttonKey.currentState?.showLoader();
      // AuthHelper.sendForgotPasswordOtp(phone!).then((value) {
      //   Get.toNamed(ForgotPasswordVerificationPage.routeName,
      //       arguments: {"data": value, "phone": phone});
      // }).catchError((e, s) {
      //   SnackBarHelper.show(e.toString());
      // }).whenComplete(() => buttonKey.currentState?.hideLoader());
    }
  }

  void resendOtp() async {
    // try {
    //   await AuthHelper.sendResendOtp();
    // } catch (e) {
    //   SnackBarHelper.show(e.toString());
    // }
  }
}
