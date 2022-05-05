import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

///
/// Created by Kumar Sunil from Boiler plate
///
class DashboardPage extends StatelessWidget {
  static const routeName = '/';

  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     LocationResult? result =
      //         await Navigator.of(context).push(MaterialPageRoute(
      //             builder: (context) => AppPlacePicker(
      //                   Environment.mapApiKey,
      //                 )));
      //     if (result != null) {}
      //   },
      // ),
      appBar: AppBar(
        title: const Text('Boiler Plate'),
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          itemCount: 100,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: Duration(seconds: 1),
              child: SlideAnimation(
                verticalOffset: 50.0,
                duration: Duration(seconds: 1),
                child: FadeInAnimation(
                  duration: Duration(seconds: 1),
                  child: ListTile(
                    leading: CircleAvatar(),
                    title: Text("Name"),
                    subtitle: Text("Description"),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
