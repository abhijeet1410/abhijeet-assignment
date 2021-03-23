import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobile_template/app_configs/app_decorations.dart';
import 'package:flutter_mobile_template/widgets/app_buttons/app_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class UpdatePasswordPage extends StatefulWidget {
  static const routeName = '/update-password';

  @override
  _UpdatePasswordPageState createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<AppPrimaryButtonState> _buttonKey = GlobalKey();
  bool _autoValidate = false;
  late String _user, _token;
  String? _password;

  String? _confirmPassword;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> map = Get.arguments as Map<String, dynamic>;
    _user = map['user'];
    _token = map['token'];
  }

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
                    Text('Update password', style: TextStyle(fontSize: 26)),
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
                                _password = s!.trim();
                              },
                              keyboardType: TextInputType.emailAddress,
                              obscureText: true,
                              validator: (s) {
                                _password = s!.trim();
                                if (_password!.isEmpty) {
                                  return '*required';
                                } else if (_password!.length < 8) {
                                  return "Password must be at least 8 chars long.";
                                }
                                return null;
                              },
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                              decoration:
                                  AppDecorations.textFieldDecoration(context)
                                      .copyWith(
                                          hintText: 'New password',
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.all(3),
                                            child: Material(
                                                type: MaterialType.circle,
                                                color: Colors.white,
                                                child: Center(
                                                  widthFactor: 0,
                                                  child: Icon(
                                                    Icons.lock,
                                                    size: 18,
                                                  ),
                                                )),
                                          )),
                            ),
                            SizedBox(height: 14),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (s) =>
                                  FocusScope.of(context).nextFocus(),
                              onSaved: (s) {
                                _confirmPassword = s!.trim();
                              },
                              keyboardType: TextInputType.emailAddress,
                              obscureText: true,
                              validator: (s) {
                                _confirmPassword = s!.trim();
                                if (s.trim().isEmpty) {
                                  return '*required';
                                } else if (_password != _confirmPassword) {
                                  return "Passwords must be same.";
                                }
                                return null;
                              },
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                              decoration:
                                  AppDecorations.textFieldDecoration(context)
                                      .copyWith(
                                          hintText: 'Confirm password',
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.all(3),
                                            child: Material(
                                                type: MaterialType.circle,
                                                color: Colors.white,
                                                child: Center(
                                                  widthFactor: 0,
                                                  child: Icon(
                                                    Icons.lock,
                                                    size: 18,
                                                  ),
                                                )),
                                          )),
                            ),
                            SizedBox(height: 14),
                            AppPrimaryButton(
                                key: _buttonKey,
                                child: Text('SUBMIT'),
                                onPressed: _updatePassword),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                    Spacer(flex: 6),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updatePassword() {
    // final state = _formKey.currentState;
    // if (!state.validate()) {
    //   setState(() {
    //     _autoValidate = true;
    //   });
    // } else {
    //   state.save();

    //   _buttonKey.currentState.showLoader();
    //   AuthHelper.changePassword(_confirmPassword, _user, _token).then((value) {
    //     Navigator.popUntil(
    //         context,
    //         (route) =>
    //             route.settings.name == LoginPage.routeName ||
    //             route.settings.name == BusinessLoginPage.routeName);
    //     SnackBarHelper.show("Success", "Password reset successfully.");
    //   }).catchError((err, s) {
    //     log("ERROR " + err.toString(), stackTrace: s);
    //     SnackBarHelper.show("Error", err.toString());
    //   }).whenComplete(() => _buttonKey.currentState.hideLoader());
    // }
  }
}
