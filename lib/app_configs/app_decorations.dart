import 'package:flutter/material.dart';

import 'app_colors.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
mixin AppDecorations {
  static const introLinearGradient = LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [Color(0xff312A87), Color(0xff213068)]);

  static InputDecoration textFieldDecoration(BuildContext context,
      {double radius = 8}) {
    return InputDecoration(
        // fillColor: Colors.grey.shade200,
        filled: false,
        counterText: '',
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
        contentPadding: EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 16.0),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade300
                  : AppColors.borderColor,
              width: 1.2,
            )),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade300
                  : AppColors.borderColor,
              width: 1.2,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 1.2,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade300
                  : AppColors.borderColor,
              width: 1.2,
            )));
  }
}
