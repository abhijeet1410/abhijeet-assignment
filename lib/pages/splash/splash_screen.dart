import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:god_flutter/app_configs/app_assets.dart';
import 'package:god_flutter/app_configs/app_decorations.dart';
import 'package:god_flutter/utils/app_auth_helper.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class SplashPage extends StatefulWidget {
  static const routeName = '/';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      AuthHelper.refreshAccessToken().whenComplete(() {
        AuthHelper.checkUserLevel();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppDecorations.introLinearGradient),
        child: Center(
            child: SvgPicture.asset(
          AppAssets.logo,
        )),
      ),
    );
  }
}
