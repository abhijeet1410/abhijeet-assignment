import 'package:flutter/material.dart';

class LoginEmailOtpPage extends StatefulWidget {
  static const String routeName = '/loginEmailOtp';

  @override
  _LoginEmailOtpPageState createState() => _LoginEmailOtpPageState();
}

class _LoginEmailOtpPageState extends State<LoginEmailOtpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginEmailOtp'),
      ),
    );
  }
}
