import 'package:flutter/material.dart';
import 'package:flutter_mobile_template/app_configs/app_assets.dart';
import 'package:flutter_mobile_template/generated/l10n.dart';
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
      S.of(context).intro1,
      S.of(context).intro2,
      S.of(context).intro3,
      S.of(context).intro4
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
