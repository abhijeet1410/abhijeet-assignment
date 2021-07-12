import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:god_flutter/app_configs/app_colors.dart';
import 'package:god_flutter/app_configs/environment.dart';
import 'package:god_flutter/pages/authenticaton/controllers/otp_controller.dart';
import 'package:god_flutter/widgets/app_buttons/app_back_button.dart';
import 'package:god_flutter/widgets/app_buttons/app_primary_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

///
/// Created by Kumar Sunil from Boiler plate
///
class OtpVerificationPage extends StatefulWidget {
  static const String routeName = '/otp-verification';

  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState
    extends State<OtpVerificationPage> /*with CodeAutoFill */ {
  late OtpController _otpController;

  @override
  void initState() {
    super.initState();
    _otpController = OtpController();
    _otpController.onInit();
  }

  @override
  void dispose() {
    // unregisterListener();
    // cancel();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBackButton(
              padding: const EdgeInsets.all(16),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Text(
                'Verify OTP',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(fontFamily: Environment.fontFamily),
                      children: [
                        TextSpan(
                          text:
                              'Please enter the OTP that has been sent to your given Phone no. ',
                          style: TextStyle(color: const Color(0xff929292)),
                        ),
                        TextSpan(
                            text: '+91 ${_otpController.phone}',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black))
                      ]),
                )),
            Center(
              child: Container(
                width: 250,
                margin: const EdgeInsets.only(left: 16, right: 16),
                child: PinCodeTextField(
                  controller: _otpController.textController,
                  length: 4,
                  autoDisposeControllers: false,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  textStyle: TextStyle(color: Colors.black, fontSize: 22),
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderWidth: 2,
                      borderRadius: BorderRadius.circular(8),
                      activeColor: theme.primaryColor,
                      inactiveColor: AppColors.borderColor,
                      selectedColor: Colors.black),
                  onChanged: _otpController.onChanged,
                  onCompleted: _otpController.onCompleted,
                  appContext: context,
                ),
              ),
            ),
            SizedBox(height: 22),
            Center(
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _otpController.timerText,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600),
                    ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Didn\'t receive the code? ',
                          style: TextStyle(color: Colors.grey)),
                      TextSpan(
                          text: 'Resend',
                          style: TextStyle(fontWeight: FontWeight.w600)
                              .copyWith(
                                  color: _otpController.isResendActive.value
                                      ? theme.primaryColor
                                      : Colors.grey),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              if (_otpController.isResendActive.value) {
                                _otpController.regenerateOTP();
                              }
                            })
                    ]))
                  ],
                ),
              ),
            ),
            Spacer(),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 22),
                child: AppPrimaryButton(
                    width: Get.width,
                    key: _otpController.buttonKey,
                    child: Text('Continue'),
                    onPressed: _otpController.loginUsingOtp),
              ),
            ),
          ],
        ),
      ),
    );
  }

// @override
// void codeUpdated() => _otpController.onCodeUpdated(code!);
}
