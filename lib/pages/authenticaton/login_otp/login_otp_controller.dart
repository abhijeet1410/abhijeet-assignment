import 'dart:async';

import 'package:flutter/material.dart';
import 'package:assignment_pay/pages/dashboard/dashboard_page.dart';
import 'package:assignment_pay/utils/snackbar_helper.dart';
import 'package:assignment_pay/widgets/app_buttons/app_primary_button.dart';
import 'package:get/get.dart';
// import 'package:sms_autofill/sms_autofill.dart';

///
///Created By Sisira Sahoo (coolsisira1998@gmail.com) on 24-07-2021 17:37
///

class LoginOtpController extends GetxController {
  String pin = "";
  RxBool isResendActive = RxBool(false);
  late Timer _timer;
  RxInt timerCounter = RxInt(59);
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  late String phone;
  late TextEditingController? textController;

  String get timerText =>
      '00:${timerCounter < 10 ? timerCounter.toString().padLeft(2, '0') : timerCounter}';

  void onCodeUpdated(String code) {
    textController?.text = code;
  }

  @override
  void onInit() {
    super.onInit();
    textController = TextEditingController();

    final Map<String, dynamic>? map = Get.arguments as Map<String, dynamic>;
    if (map != null) {
      phone = map['phone'];
      //_isFromOnBoarding = map['isFromOnBoarding'] ?? false;
    }
    // _listenOtp();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    timerCounter.close();
    isResendActive.close();
    textController?.dispose();
    textController = null;
    super.dispose();
  }

  // Future<void> _listenOtp() async {
  //   await SmsAutoFill().listenForCode;
  // }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        isResendActive.value = timerCounter < 20;

        if (timerCounter.value < 1) {
          timer.cancel();
        } else {
          timerCounter.value -= 1;
        }
      },
    );
  }

  regenerateOTP() {
    _timer.cancel();
    isResendActive.value = false;
    timerCounter.value = 59;
    buttonKey.currentState?.showLoader();
    // AuthHelper.sendLoginPhoneOtp(phone).then((value) {
    //   //SnackBarHelper.show("OTP successfully sent to $phone");
    //   buttonKey.currentState?.hideLoader();
    //   startTimer();
    // }).catchError((err) {
    //   buttonKey.currentState?.hideLoader();
    //   SnackBarHelper.show(err.toString());
    // });
  }

  loginUsingOtp() {
    if (pin.isEmpty) {
      SnackBarHelper.show('Please enter pin to continue');
    } else {
      _verify();
    }
  }

  void _verify() {
    Get.focusScope!.unfocus();
    if (pin.isEmpty || pin.length != 6) {
      SnackBarHelper.show('Please enter pin to continue');
    } else {
      Get.offAllNamed(DashboardPage.routeName);
      // buttonKey.currentState?.showLoader();
      // AuthHelper.verifyLoginPhoneOtp(phone, pin).then((value) {
      //   SharedPreferenceHelper.storeUser(user: value);
      //   if (value.user?.phone == null) {
      //     SharedPreferenceHelper.setUserTempPhone = phone;
      //   }
      //   AuthHelper.checkUserLevel();
      // }).catchError((e, s) {
      //   textController?.clear();
      //   log("loginUsingOtp", error: e, stackTrace: s);
      //   SnackBarHelper.show(e.toString());
      // }).whenComplete(() => buttonKey.currentState?.hideLoader());
    }
  }

  void onChanged(String value) {
    pin = value.trim();
  }

  void onCompleted(String value) {
    pin = value.trim();
    _verify();
  }
}
