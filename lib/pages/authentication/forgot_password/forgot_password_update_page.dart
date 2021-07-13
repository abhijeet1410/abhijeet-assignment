import 'package:flutter/material.dart';

class ForgotPasswordUpdatePage extends StatefulWidget {
  static const String routeName = '/forgotPasswordUpdate';

  @override
  _ForgotPasswordUpdatePageState createState() =>
      _ForgotPasswordUpdatePageState();
}

class _ForgotPasswordUpdatePageState extends State<ForgotPasswordUpdatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ForgotPasswordUpdate'),
      ),
    );
  }
}
