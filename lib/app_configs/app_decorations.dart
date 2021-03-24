import 'package:flutter/material.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
mixin AppDecorations {
  static InputDecoration textFieldDecoration(BuildContext context,
      {double radius = 8}) {
    return InputDecoration(
        fillColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade200
            : Colors.grey.shade200,
        filled: true,
        counterText: '',
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
        contentPadding: EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 16.0),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade300
                  : Colors.grey.shade700,
              width: 2,
            )),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade300
                  : Colors.grey.shade700,
              width: 2,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade300
                  : Colors.grey.shade700,
              width: 2,
            )));
  }
}
