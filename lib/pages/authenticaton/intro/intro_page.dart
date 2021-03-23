import 'package:flutter/material.dart';
import 'package:flutter_mobile_template/app_configs/app_assets.dart';
import 'package:flutter_mobile_template/pages/authenticaton/intro/controller/intro_controller.dart';
import 'package:flutter_mobile_template/widgets/app_buttons/app_button.dart';
import 'package:get/get.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class IntroPage extends StatefulWidget {
  static const String routeName = '/intro';

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final IntroController _introController = IntroController();
  @override
  void initState() {
    super.initState();
    _introController.initController();
  }

  @override
  void dispose() {
    _introController.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final introQuotes = [
      'Best quality\ngrocery at your\ndoorstep!',
      'Peace of mind,\nsame day\ndelivery or pickup.',
      'Get quality grocery\non every order.',
      'Big savings with\nseasonal discounts\non all products.'
    ];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: introQuotes.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    SizedBox(height: 22),
                    Text(AppAssets.introAssets[index]),
                    SizedBox(height: 12),
                    Text(
                      introQuotes[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: AppPrimaryButton(
                      child: Text('Login'),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: AppOutlineButton(
                      child: Text('Register'),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
