import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobile_template/widgets/app_buttons/app_button.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class ForgotPasswordOtpPage extends StatefulWidget {
  static const routeName = '/forgot-password-otp';

  @override
  _ForgotPasswordOtpPageState createState() => _ForgotPasswordOtpPageState();
}

class _ForgotPasswordOtpPageState extends State<ForgotPasswordOtpPage> {
  String _otp = "";
  bool _isResendActive = false;
  late Timer _timer;
  int _timerCounter = 59;
  final GlobalKey<AppPrimaryButtonState> _buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  late String _type;
  late String _user;
  late String _field;

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
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

  Future<void> _listenOtp() async {
//    await SmsAutoFill().listenForCode;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 26),
                    Text('Verification code', style: TextStyle(fontSize: 26)),
                    SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 36),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 18),
                            Text(
                              'Please enter 4 digit code sent to\nyour registered ${_type == 'email' ? 'email id' : 'phone'}\n$_field',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            SizedBox(height: 18),
                            PinCodeTextField(
                              appContext: context,
                              onChanged: (s) {
                                _otp = s.trim();
                              },
                              length: 4,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              autoFocus: true,
                              onCompleted: (pin) {
                                FocusScope.of(context).unfocus();
                                _submitOtp();
                              },
                            ),
                            SizedBox(height: 14),
                            Row(
                              children: [
                                Container(
                                  width: 54,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "$_timerCounter",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.red),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: AppPrimaryButton(
                                      key: _buttonKey,
                                      child: Text('SUBMIT'),
                                      onPressed: _submitOtp,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 32),
                              ],
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    TextButton(
                        onPressed: _isResendActive ? _regenerateOTP : null,
                        // textColor: Get.theme.primaryColor,
                        child: Text(
                          'Resend OTP',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 16),
                        )),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (mounted)
          setState(
            () {
              if (_timerCounter == 15) _isResendActive = true;
              if (_timerCounter < 1) {
                timer.cancel();
              } else {
                _timerCounter = _timerCounter - 1;
              }
            },
          );
      },
    );
  }

  _regenerateOTP() {
    _timer.cancel();
    setState(() {
      _isResendActive = false;
      _timerCounter = 59;
    });
    //   _buttonKey.currentState.showLoader();
    //   AuthHelper.sendResetOtp(_user, _type == "email").then((value) {
    //     _buttonKey.currentState.hideLoader();
    //     _startTimer();
    //   }).catchError((err) {
    //     SnackBarHelper.show("Error", err.toString());
    //     _buttonKey.currentState.hideLoader();
    //   });
  }

  void _submitOtp() {
    //   _buttonKey.currentState.showLoader();
    //   AuthHelper.getResetToken(_otp, _user).then((value) {
    //     _buttonKey.currentState.hideLoader();
    //     Get.toNamed(UpdatePasswordPage.routeName, arguments: value);
    //   }).catchError((err) {
    //     SnackBarHelper.show("Error", err.toString());
    //     _buttonKey.currentState.hideLoader();
    //   });
  }
}
