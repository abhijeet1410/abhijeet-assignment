import 'package:flutter/material.dart';

class LoginPhonePage extends StatefulWidget {
  static const String routeName = '/loginPhone';

  @override
  _LoginPhonePageState createState() => _LoginPhonePageState();
}

class _LoginPhonePageState extends State<LoginPhonePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginPhone'),
      ),
    );
  }
}
