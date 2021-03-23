import 'package:flutter/material.dart';
import 'package:flutter_mobile_template/app_configs/app_decorations.dart';
import 'package:flutter_mobile_template/widgets/app_buttons/app_button.dart';
import 'package:get/get.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class ForgotPasswordOptionPage extends StatefulWidget {
  static const String routeName = '/ForgotPasswordOptionPage';

  @override
  _ForgotPasswordOptionPageState createState() =>
      _ForgotPasswordOptionPageState();
}

class _ForgotPasswordOptionPageState extends State<ForgotPasswordOptionPage> {
  final GlobalKey<AppPrimaryButtonState> _buttonKey = GlobalKey();
  bool _isEmailChecked = true;
  late String _email, _phone, _userId;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>;
    _email = args['email'];
    _phone = args['phone'];
    _userId = args['userId'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 32),
              Text('Forgot password', style: TextStyle(fontSize: 26)),
              SizedBox(height: 12),
              Text(
                  'We will send you a 4 digit\ncode to your registered\nemail or phone number.\n\nPlease select your email or\nphone number for the\nverification process.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 18),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isEmailChecked = true;
                        });
                      },
                      child: Row(
                        children: [
                          Material(
                            color: Colors.white,
                            type: MaterialType.circle,
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Material(
                                type: MaterialType.circle,
                                color: !_isEmailChecked
                                    ? Colors.transparent
                                    : Colors.grey.shade800,
                                child: SizedBox(height: 22, width: 22),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              enabled: false,
                              initialValue: _email,
                              style: TextStyle(color: Colors.white),
                              decoration:
                                  AppDecorations.textFieldDecoration(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isEmailChecked = false;
                        });
                      },
                      child: Row(
                        children: [
                          Material(
                            color: Colors.white,
                            type: MaterialType.circle,
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Material(
                                type: MaterialType.circle,
                                color: _isEmailChecked
                                    ? Colors.transparent
                                    : Colors.grey.shade800,
                                child: SizedBox(height: 22, width: 22),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              enabled: false,
                              initialValue: _phone,
                              style: TextStyle(color: Colors.white),
                              decoration:
                                  AppDecorations.textFieldDecoration(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14),
                    AppPrimaryButton(
                        key: _buttonKey,
                        child: Text('CONTINUE'),
                        onPressed: _sendOtp),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void _sendOtp() {
    // _buttonKey.currentState.showLoader();
    // AuthHelper.sendResetOtp(_userId, _isEmailChecked).then((value) {
    //   value['field'] = value['type'] == 'email' ? _email : _phone;
    //   Get.toNamed(ForgotPasswordOtpPage.routeName, arguments: value);
    // }).catchError((err, s) {
    //   SnackBarHelper.show('Error', '$err');
    // }).whenComplete(() => {_buttonKey.currentState.hideLoader()});
  }
}
