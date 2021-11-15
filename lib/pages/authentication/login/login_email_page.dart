import 'package:flutter/material.dart';

class LoginEmailPage extends StatefulWidget {
  static const String routeName = '/loginEmail';

  @override
  _LoginEmailPageState createState() => _LoginEmailPageState();
}

class _LoginEmailPageState extends State<LoginEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginEmail'),
      ),
    );
  }
}
