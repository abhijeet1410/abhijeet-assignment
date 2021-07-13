import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:god_flutter/app_configs/app_assets.dart';

///
/// Created by Kumar Sunil from Boiler plate
///
class DashboardPage extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gods Own Diva'),
        actions: [
          IconButton(onPressed: () {}, icon: SvgPicture.asset(AppAssets.search))
        ],
      ),
      drawer: Drawer(),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(tabs: [Tab(text: 'Groups'), Tab(text: 'Community')]),
            Expanded(
                child: TabBarView(
              children: [],
            ))
          ],
        ),
      ),
    );
  }
}
