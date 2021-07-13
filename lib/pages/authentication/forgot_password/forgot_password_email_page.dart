import 'package:flutter/material.dart';

class ForgotPasswordEmailPage extends StatefulWidget {
  static const String routeName = '/forgotPasswordEmail';

  @override
  _ForgotPasswordEmailPageState createState() =>
      _ForgotPasswordEmailPageState();
}

class _ForgotPasswordEmailPageState extends State<ForgotPasswordEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ForgotPasswordEmail'),
      ),
    );
  }
}
