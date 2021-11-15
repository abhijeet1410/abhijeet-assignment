import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobile_template/widgets/app_buttons/app_primary_button.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'login_otp_controller.dart';

class LoginOtpPage extends StatefulWidget {
  static const String routeName = '/Otp';

  const LoginOtpPage({Key? key}) : super(key: key);

  @override
  _LoginOtpPageState createState() => _LoginOtpPageState();
}

class _LoginOtpPageState extends State<LoginOtpPage> /*with CodeAutoFill*/ {
  late LoginOtpController _otpController;

  @override
  void initState() {
    super.initState();
    _otpController = LoginOtpController();
    _otpController.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    // unregisterListener();
    // cancel();
    _otpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Form(
            child: ListView(
              children: [
                const SizedBox(
                  height: 18,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: BackButton(
                    onPressed: () {
                      Get.back();
                    },
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),

                const SizedBox(
                  height: 58,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Text(
                        'Verify OTP',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: theme.textTheme.bodyText2,
                            children: [
                              TextSpan(
                                  text:
                                      'Please enter the OTP that has been sent to your given Phone no.',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff2D2D2D),
                                  )),
                              TextSpan(
                                text: '+91 ${_otpController.phone}',
                                style: TextStyle(
                                    color: Color(0xff2D2D2D),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                //SizedBox(height: 60,),
                Container(
                    width: 250,
                    margin: const EdgeInsets.only(
                        left: 16, right: 16, top: 60, bottom: 50),
                    child: PinCodeTextField(
                      appContext: context,
                      length: 6,
                      autoFocus: true,
                      autoDisposeControllers: false,
                      controller: _otpController.textController,
                      onChanged: _otpController.onChanged,
                      onSubmitted: _otpController.onCompleted,
                      onCompleted: _otpController.onCompleted,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      textStyle: TextStyle(color: Colors.black, fontSize: 18),
                      pinTheme: PinTheme(
                        fieldHeight: 63,
                        fieldWidth: 46,
                        shape: PinCodeFieldShape.box,
                        borderWidth: 1,
                        borderRadius: BorderRadius.circular(6),
                        activeColor: theme.primaryColor,
                        inactiveColor: Color(0xffCEDCE5),
                        selectedColor: theme.primaryColor,
                      ),
                    )),
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _otpController.timerText,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'Didn\'t receive the code?',
                            style: TextStyle(color: Colors.grey)),
                        TextSpan(
                            text: ' Resend',
                            style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 12)
                                .copyWith(
                                    color: _otpController.isResendActive.value
                                        ? Color(0xff037FFB)
                                        : Colors.grey),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                if (_otpController.isResendActive.value) {
                                  _otpController.regenerateOTP();
                                }
                              })
                      ])),
                    ],
                  ),
                ),
                SizedBox(
                  height: height / 4 - 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AppPrimaryButton(
                    width: Get.width,
                    key: _otpController.buttonKey,
                    onPressed: _otpController.loginUsingOtp,
                    child: Text('Verify'),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ]));
  }

// @override
// void codeUpdated() {
//   return _otpController.onCodeUpdated(code!);
// }
}
