import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_template/app_configs/app_assets.dart';
import 'package:flutter_mobile_template/generated/l10n.dart';
import 'package:flutter_mobile_template/pages/authenticaton/pages/login/login_page.dart';
import 'package:flutter_mobile_template/pages/authenticaton/pages/register/register_page.dart';
import 'package:flutter_mobile_template/widgets/app_buttons/app_outline_button.dart';
import 'package:flutter_mobile_template/widgets/app_buttons/app_primary_button.dart';
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
                child: CarouselSlider(
              items: List.generate(
                  introQuotes.length,
                  (index) => Column(
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
                      )),
              options: CarouselOptions(
                  // height: 400,
                  aspectRatio: 1,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 5),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal),
            )),
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
