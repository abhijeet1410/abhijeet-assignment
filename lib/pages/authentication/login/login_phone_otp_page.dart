import 'package:flutter/material.dart';

class LoginPhoneOtpPage extends StatefulWidget {
  static const String routeName = '/loginPhoneOtp';

  @override
  _LoginPhoneOtpPageState createState() => _LoginPhoneOtpPageState();
}

class _LoginPhoneOtpPageState extends State<LoginPhoneOtpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginPhoneOtp'),
      ),
    );
  }
}
