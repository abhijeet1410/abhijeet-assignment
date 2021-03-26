import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobile_template/pages/authenticaton/controllers/forgot_password_otp_controller.dart';
import 'package:flutter_mobile_template/widgets/app_buttons/app_primary_button.dart';
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
  late ForgotPasswordOtpController _otpController;

  @override
  void initState() {
    super.initState();
    _otpController = ForgotPasswordOtpController();
    _otpController.onInit();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Enter OTP'),
      ),
      body: SafeArea(
        child: Obx(
          () => SingleChildScrollView(
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
                          _otpController.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(height: 18),
                        PinCodeTextField(
                          appContext: context,
                          onChanged: _otpController.onChangeOtp,
                          length: 4,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          autoFocus: true,
                          onCompleted: (pin) {
                            FocusScope.of(context).unfocus();
                            _otpController.submitOtp();
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
                                "${_otpController.timerCounter}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.red),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: AppPrimaryButton(
                                  key: _otpController.buttonKey,
                                  child: Text('SUBMIT'),
                                  onPressed: _otpController.submitOtp,
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
                    onPressed: _otpController.isResendActive.value ?? false
                        ? _otpController.regenerateOTP
                        : null,
                    // textColor: Get.theme.primaryColor,
                    child: Text(
                      'Resend OTP',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                    )),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
