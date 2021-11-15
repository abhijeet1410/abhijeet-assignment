import 'package:flutter/material.dart';

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
        actions: [],
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
