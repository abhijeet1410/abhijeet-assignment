import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobile_template/pages/authenticaton/pages/reset_password/update_password_page.dart';
import 'package:flutter_mobile_template/widgets/app_buttons/app_primary_button.dart';
import 'package:get/get.dart';

///
/// Created by Kumar Sunil from Boiler plate
///
class ForgotPasswordOtpController extends GetxController {
  String _otp = "";
  late RxBool isResendActive;
  late Timer _timer;
  late RxInt timerCounter;
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  late String _type;
  late String _user;
  late String _field;
  late TextEditingController _controller;

  String get description =>
      'Please enter 4 digit code sent to\nyour registered ${_type == 'email' ? 'email id' : 'phone'}\n$_field';

  @override
  void onInit() {
    super.onInit();
    isResendActive = RxBool(false);
    timerCounter = RxInt((59));
    _controller = TextEditingController();
//    SmsAutoFill()
//        .getAppSignature
//        .then((value) => SnackBarHelper.show('', 'Signature $value'));
    Map<String, dynamic> map = Get.arguments as Map<String, dynamic>;
    _type = map['type'];
    _user = map['user'];
    _field = map['field'];
    _listenOtp();
    _startTimer();
  }

  @override
  void dispose() {
    isResendActive.close();
    timerCounter.close();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _listenOtp() async {
//    await SmsAutoFill().listenForCode;
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (this.hasListeners) if (timerCounter.value == 15)
          isResendActive.value = true;
        if (timerCounter < 1) {
          timer.cancel();
        } else {
          timerCounter.value = timerCounter.value - 1;
        }
      },
    );
  }

  regenerateOTP() {
    _timer.cancel();
    isResendActive.value = false;
    timerCounter.value = 59;
    //   _buttonKey.currentState.showLoader();
    //   AuthHelper.sendResetOtp(_user, _type == "email").then((value) {
    //     _buttonKey.currentState.hideLoader();
    //     _startTimer();
    //   }).catchError((err) {
    //     SnackBarHelper.show("Error", err.toString());
    //     _buttonKey.currentState.hideLoader();
    //   });
  }

  void onChangeOtp(String value) {
    _otp = value.trim();
  }

  void submitOtp() {
    //   _buttonKey.currentState.showLoader();
    //   AuthHelper.getResetToken(_otp, _user).then((value) {
    //     _buttonKey.currentState.hideLoader();
    Get.toNamed(UpdatePasswordPage.routeName);
    //   }).catchError((err) {
    //     SnackBarHelper.show("Error", err.toString());
    //     _buttonKey.currentState.hideLoader();
    //   });
  }
}
