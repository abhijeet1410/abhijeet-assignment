import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool?> showLocalStoreAlertDialog(
    {String title = '',
    String? description,
    String positiveText = 'Ok',
    String negativeText = 'Cancel'}) async {
  if (Platform.isAndroid)
    return Get.dialog<bool>(AlertDialog(
      title: Text(title),
      content: description != null ? Text(description) : null,
      actions: [
        FlatButton(
          child: Text(negativeText),
          onPressed: () {
            Get.back(result: false);
          },
        ),
        FlatButton(
          child: Text(positiveText),
          onPressed: () => Get.back(result: true),
        ),
      ],
    ));
  else
    return Get.dialog(CupertinoAlertDialog(
      title: Text(title),
      content: description != null ? Text(description) : null,
      actions: [
        CupertinoDialogAction(
          child: Text('No'),
          onPressed: () {
            Get.back(result: false);
          },
        ),
        CupertinoDialogAction(
          child: Text('Yes'),
          onPressed: () => Get.back(result: true),
        ),
      ],
    ));
}
