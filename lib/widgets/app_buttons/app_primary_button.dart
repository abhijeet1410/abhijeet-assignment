import 'package:assignment_pay/app_configs/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:assignment_pay/app_configs/environment.dart';
import 'package:get/get.dart';

import '../app_loader.dart';

class AppPrimaryButton extends StatefulWidget {
  const AppPrimaryButton(
      {required this.child,
        Key? key,
        this.onPressed,
        this.height,
        this.width,
        this.color,
        this.shape,
        this.padding,
        this.textStyle})
      : super(key: key);

  final ShapeBorder? shape;
  final Widget child;
  final VoidCallback? onPressed;
  final double? height, width;
  final Color? color;
  final EdgeInsets? padding;
  final TextStyle? textStyle;

  @override
  AppPrimaryButtonState createState() => AppPrimaryButtonState();
}

class AppPrimaryButtonState extends State<AppPrimaryButton> {
  bool _isLoading = false;

  void showLoader() {
    setState(() {
      _isLoading = true;
    });
  }

  void hideLoader() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _isLoading
        ? AppProgress(color: widget.color ?? theme.primaryColor)
        : ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Get.isDarkMode
            ? AppColors.lightPurple
            : AppColors.brightPrimary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)),
        padding: widget.padding ??
            const EdgeInsets.symmetric(vertical: 14, horizontal: 48),
        fixedSize: Size(MediaQuery.of(context).size.width, 52),

        textStyle: widget.textStyle ??
            const TextStyle(
                fontSize: 14,
                fontFamily: Environment.fontFamily,
                letterSpacing: 1.4,
                color: Colors.white,
                fontWeight: FontWeight.w500),
      ),
      onPressed: widget.onPressed,
      child: widget.child,
    );
  }
}
