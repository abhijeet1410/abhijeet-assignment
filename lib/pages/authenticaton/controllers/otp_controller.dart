import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:god_flutter/utils/app_auth_helper.dart';
import 'package:god_flutter/utils/shared_preference_helper.dart';
import 'package:god_flutter/utils/snackbar_helper.dart';
import 'package:god_flutter/widgets/app_buttons/app_primary_button.dart';
// import 'package:sms_autofill/sms_autofill.dart';

///
/// Created by Kumar Sunil from Boiler plate
///
class OtpController extends GetxController {
  String pin = "";
  RxBool isResendActive = RxBool(false);
  late Timer _timer;
  RxInt timerCounter = RxInt(59);
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  late String phone;
  late TextEditingController? textController;
  String? _parentPath;

  bool _isFromOnBoarding = false;

  String get timerText =>
      '00:${timerCounter < 10 ? timerCounter.toString().padLeft(2, '0') : timerCounter}';

  void onCodeUpdated(String code) {
    textController?.text = code;
  }

  @override
  void onInit() {
    super.onInit();
    textController = TextEditingController();
    // SmsAutoFill().getAppSignature.then((value) {
    //   log("APP SIGNATURE $value");
    // });
    final Map<String, dynamic>? map = Get.arguments as Map<String, dynamic>;
    if (map != null) {
      phone = map['phone'];
      _parentPath = map['parent'];
      _isFromOnBoarding = map['isFromOnBoarding'] ?? false;
    }
    _listenOtp();
    startTimer();
    // Future.delayed(const Duration(minutes: 1), () {
    //   isResendActive = true;
    // });
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

  Future<void> _listenOtp() async {
    // await SmsAutoFill().listenForCode;
  }

  ///Timer
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        isResendActive.value = timerCounter < 15;

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
    AuthHelper.userLoginWithPhone(phone).then((value) {
      buttonKey.currentState?.hideLoader();
      startTimer();
    }).catchError((err) {
      buttonKey.currentState?.hideLoader();
      SnackBarHelper.show('', err.toString());
    });
  }

  void loginUsingOtp() {
    if (pin.isEmpty) {
      SnackBarHelper.show('Error', 'Please enter pin to continue');
    } else {
      _login();
    }
  }

  void _login() {
    Get.focusScope!.unfocus();
    if (pin.isEmpty || pin.length != 4) {
      SnackBarHelper.show('', 'Please enter pin to continue');
    } else {
      buttonKey.currentState?.showLoader();
      AuthHelper.verifyLoginOtp(phone, pin).then((value) {
        SharedPreferenceHelper.storeAccessToken(value.accessToken);
        SharedPreferenceHelper.storeUser(user: value);
        if (_isFromOnBoarding) {
          // Get.until((route) => route.settings.name == _parentPath);
          Get.back(result: true);
        } else {
          AuthHelper.checkUserLevel(phone: phone, parentPath: _parentPath);
        }
      }).catchError((e, s) {
        log("loginPhoneNumber", error: e, stackTrace: s);
        SnackBarHelper.show('', e.toString());
      }).whenComplete(() => buttonKey.currentState?.hideLoader());
    }
  }

  void onChanged(String value) {
    pin = value.trim();
  }

  void onCompleted(String value) {
    pin = value.trim();
    _login();
  }
}
