import 'package:flutter/material.dart';
import 'package:flutter_mobile_template/pages/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter_mobile_template/widgets/app_buttons/app_primary_button.dart';
import 'package:get/get.dart';

///
/// Created by Kumar Sunil from Boiler plate
///
class ExplorePage extends StatefulWidget {
  static const routeName = '/explore';

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(child: Text('Explore')),
          Center(
            child: AppPrimaryButton(
                child: Text('Go to Profile'),
                onPressed: () {
                  final dashboardController = Get.find<DashboardController>();
                  dashboardController.onTapBottomNav(2);
                }),
          ),
        ],
      ),
    );
  }
}
