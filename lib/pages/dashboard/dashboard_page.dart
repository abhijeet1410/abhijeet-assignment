import 'package:flutter/material.dart';
import 'package:flutter_mobile_template/app_configs/environment.dart';
import 'package:flutter_mobile_template/widgets/place_picker.dart';
import 'package:place_picker/place_picker.dart';

///
/// Created by Kumar Sunil from Boiler plate
///
class DashboardPage extends StatelessWidget {
  static const routeName = '/';

  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          LocationResult? result =
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AppPlacePicker(
                        Environment.mapApiKey,
                      )));
          if (result != null) {}
        },
      ),
      appBar: AppBar(
        title: const Text('Boiler Plate'),
      ),
    );
  }
}
