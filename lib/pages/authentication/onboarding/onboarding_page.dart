import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  static const String routeName = '/onboarding';

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Onboarding'),
      ),
    );
  }
}
