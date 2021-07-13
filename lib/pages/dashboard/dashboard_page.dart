import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

///
/// Created by Kumar Sunil from Boiler plate
///
class DashboardPage extends StatelessWidget {
  static const routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gods Own Diva'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.string(
                  '''<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
<circle cx="9.41714" cy="9.41714" r="8.41714" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M15.2712 15.7085L18.5712 18.9999" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
'''))
        ],
      ),
      drawer: Drawer(),
    );
  }
}
