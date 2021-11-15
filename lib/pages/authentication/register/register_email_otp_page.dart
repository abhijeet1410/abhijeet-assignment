import 'package:flutter/material.dart';

class RegisterEmailOtpPage extends StatefulWidget {
  static const String routeName = '/registerEmailOtp';

  @override
  _RegisterEmailOtpPageState createState() => _RegisterEmailOtpPageState();
}

class _RegisterEmailOtpPageState extends State<RegisterEmailOtpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RegisterEmailOtp'),
      ),
    );
  }
}
