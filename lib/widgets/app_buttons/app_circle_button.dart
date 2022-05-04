import 'package:flutter/material.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class AppCircleButton extends StatelessWidget {
  final Color? color;
  final EdgeInsets? padding;
  final VoidCallback? onPressed;
  final Widget? child;
  final Size? size;

  const AppCircleButton(
      {Key? key,
      this.child,
      this.size,
      this.color,
      this.onPressed,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints.tight(size ?? const Size(54, 54)),
      onPressed: onPressed,
      padding: padding ?? EdgeInsets.zero,
      child: child,
      shape: const CircleBorder(),
      fillColor: color ?? Colors.white,
    );
  }
}
