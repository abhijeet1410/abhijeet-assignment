import 'package:flutter/material.dart';
import 'package:flutter_mobile_template/app_configs/app_assets.dart';
import 'package:flutter_mobile_template/utils/app_auth_helper.dart';

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
      body: Center(
          child: Image.asset(
        AppAssets.logo,
        width: 200,
      )),
    );
  }
}
