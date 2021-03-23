import 'package:flutter/material.dart';
import 'package:flutter_mobile_template/app_configs/app_decorations.dart';
import 'package:flutter_mobile_template/widgets/app_buttons/app_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class ForgotPasswordPage extends StatefulWidget {
  static const routeName = '/forgot-password';

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<AppPrimaryButtonState> _buttonKey = GlobalKey();
  bool _autoValidate = false;
  String? _field;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Form(
                key: _formKey,
                autovalidateMode: _autoValidate
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
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
                              onSaved: (s) {
                                _field = s?.trim();
                              },
                              keyboardType: TextInputType.emailAddress,
                              validator: (s) {
                                if (s == null || s.trim().isEmpty) {
                                  return '*required';
                                } else if (!GetUtils.isEmail(s.trim()) &&
                                    !GetUtils.isPhoneNumber(s.trim())) {
                                  return 'Not a valid email address or phone.';
                                }
                                return null;
                              },
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                              decoration:
                                  AppDecorations.textFieldDecoration(context)
                                      .copyWith(
                                          // hintStyle: TextStyle(
                                          // color: MyColors.lightGrey),
                                          hintText: 'Email ID or Phone',
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.all(3),
                                            child: Material(
                                                type: MaterialType.circle,
                                                color: Colors.white,
                                                child: Center(
                                                  widthFactor: 0,
                                                  child: Icon(Icons.email,
                                                      size: 18),
                                                )),
                                          )),
                            ),
                            SizedBox(height: 14),
                            AppPrimaryButton(
                                key: _buttonKey,
                                child: Text('CONTINUE'),
                                onPressed: _checkUser),
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
              ),
            )
          ],
        ),
      ),
    );
  }

  void _checkUser() {
    // final state = _formKey.currentState;
    // if (!state.validate()) {
    //   setState(() {
    //     _autoValidate = true;
    //   });
    // } else {
    //   state.save();

    //   _buttonKey.currentState.showLoader();
    //   AuthHelper.checkForgotUser(_field).then((value) {
    //     Get.toNamed(ForgotPasswordOptionPage.routeName, arguments: value);
    //   }).catchError((err, s) {
    //     SnackBarHelper.show('Error', '$err');
    //   }).whenComplete(() => {_buttonKey.currentState.hideLoader()});
    // }
  }
}
