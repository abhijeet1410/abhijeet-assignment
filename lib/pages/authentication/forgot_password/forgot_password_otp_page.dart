import 'package:flutter/material.dart';

class ForgotPasswordOtpPage extends StatefulWidget {
  static const String routeName = '/forgotPasswordOtp';

  @override
  _ForgotPasswordOtpPageState createState() => _ForgotPasswordOtpPageState();
}

class _ForgotPasswordOtpPageState extends State<ForgotPasswordOtpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ForgotPasswordOtp'),
      ),
    );
  }
}
