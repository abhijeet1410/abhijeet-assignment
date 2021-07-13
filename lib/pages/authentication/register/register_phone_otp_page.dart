import 'package:flutter/material.dart';

class RegisterPhoneOtpPage extends StatefulWidget {
  static const String routeName = '/registerPhoneOtp';

  @override
  _RegisterPhoneOtpPageState createState() => _RegisterPhoneOtpPageState();
}

class _RegisterPhoneOtpPageState extends State<RegisterPhoneOtpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RegisterPhoneOtp'),
      ),
    );
  }
}
