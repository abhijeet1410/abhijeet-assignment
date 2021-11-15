import 'package:flutter/material.dart';

class RegisterEmailPage extends StatefulWidget {
  static const String routeName = '/registerEmail';

  @override
  _RegisterEmailPageState createState() => _RegisterEmailPageState();
}

class _RegisterEmailPageState extends State<RegisterEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RegisterEmail'),
      ),
    );
  }
}
