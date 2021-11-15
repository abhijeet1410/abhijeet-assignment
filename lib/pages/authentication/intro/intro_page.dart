import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  static const String routeName = '/intro';

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Intro'),
      ),
    );
  }
}
