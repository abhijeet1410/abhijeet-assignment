import 'package:flutter/material.dart';
import 'package:flutter_mobile_template/app_configs/app_decorations.dart';
import 'package:flutter_mobile_template/pages/authenticaton/controllers/forgot_password_controller.dart';
import 'package:flutter_mobile_template/widgets/app_buttons/app_primary_button.dart';
import 'package:get/get.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class ForgotPasswordPage extends StatefulWidget {
  static const routeName = '/forgot-password';

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late ForgotPasswordController _forgotPasswordController;

  @override
  void initState() {
    super.initState();
    _forgotPasswordController = ForgotPasswordController();
    _forgotPasswordController.onInit();
  }

  @override
  void dispose() {
    _forgotPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Forgot password'),
      ),
      body: SafeArea(
          child: Obx(() => Form(
                key: _forgotPasswordController.formKey,
                autovalidateMode:
                    _forgotPasswordController.autoValidateMode.value,
                child: Column(
                  children: [
                    Spacer(),
                    Text('Forgot password', style: TextStyle(fontSize: 26)),
                    SizedBox(height: 12),
                    Text(
                        'We will send you a 4 digit\ncode to your registered\nemail or phone number.',
                        style: TextStyle(fontSize: 16)),
                    SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 36),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 18),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (s) =>
                                  FocusScope.of(context).nextFocus(),
                              onSaved: _forgotPasswordController.onFieldSaved,
                              keyboardType: TextInputType.emailAddress,
                              validator: (s) => _forgotPasswordController
                                  .emailValidator(s, context),
                              decoration:
                                  AppDecorations.textFieldDecoration(context)
                                      .copyWith(
                                          hintText: 'Email ID or Phone',
                                          prefixIcon: Icon(Icons.email)),
                            ),
                            SizedBox(height: 14),
                            AppPrimaryButton(
                                key: _forgotPasswordController.buttonKey,
                                child: Text('CONTINUE'),
                                onPressed: _forgotPasswordController.checkUser),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text('SMS charges applicable as per the Career'),
                    GestureDetector(
                      onTap: () async {},
                      behavior: HitTestBehavior.translucent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 4),
                        child: Text('Terms of Service & Privacy Policy'),
                      ),
                    ),
                    Spacer(flex: 5),
                  ],
                ),
              ))),
    );
  }
}
