import 'package:flutter/material.dart';

class RegisterPhonePage extends StatefulWidget {
  static const String routeName = '/registerPhone';

  @override
  _RegisterPhonePageState createState() => _RegisterPhonePageState();
}

class _RegisterPhonePageState extends State<RegisterPhonePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RegisterPhone'),
      ),
    );
  }
}
