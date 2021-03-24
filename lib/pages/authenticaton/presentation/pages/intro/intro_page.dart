import 'package:flutter/material.dart';
import 'package:flutter_mobile_template/app_configs/app_assets.dart';
import 'package:flutter_mobile_template/pages/authenticaton/presentation/pages/login/login_page.dart';
import 'package:flutter_mobile_template/pages/authenticaton/presentation/pages/register/register_page.dart';
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
  @override
  Widget build(BuildContext context) {
    final introQuotes = [
      'Dipped in hues of love and trust has come the festival of Holi.',
      'Holi is the time to unwind,\nDe-stress and bond with sweets, thandai and colours.\nHappy Holi',
      'Let the colors of Holi spread the message of peace and happiness.',
      'HAPPY HOLI TO YOU AND YOUR FAMILY.\nWE WISH YOUR HEALTH, PROSPERITY AND BUSINESS ACHIEVEMENTS AT THIS PRISMIC COLOUR EVE.\nMAY ALLAH BLESS YOU WITH ALL HIS MERCIES!'
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
                    Expanded(
                        flex: 2,
                        child: Image.network(
                          AppAssets.introAssets[index],
                        )),
                    SizedBox(height: 12),
                    Expanded(
                      flex: 1,
                      child: Text(
                        introQuotes[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
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
                      onPressed: () {
                        Get.toNamed(LoginPage.routeName);
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: AppOutlineButton(
                      child: Text('Register'),
                      onPressed: () {
                        Get.toNamed(RegisterPage.routeName);
                      },
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