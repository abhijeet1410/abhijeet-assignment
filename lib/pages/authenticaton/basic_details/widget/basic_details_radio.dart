import 'package:assignment_pay/app_configs/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../app_configs/app_colors.dart';

class BasicDetailsRadio extends StatelessWidget {
  final bool selected;
  final VoidCallback? onTap;
  final String text;

  const BasicDetailsRadio(
      {Key? key, this.selected = false, this.onTap, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).brightness == Brightness.light
          ? AppColors.lightGray
          : AppColors.textFieldDarkModeFillColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              if (selected)
                SvgPicture.asset(
                  AppAssets.checked,
                  color: Theme.of(context).brightness == Brightness.light
                      ? AppColors.lightBlack
                      : Colors.white,
                )
              else
                SvgPicture.asset(
                  AppAssets.unchecked,
                  color: Theme.of(context).brightness == Brightness.light
                      ? AppColors.lightBlack
                      : Colors.white,
                ),
              const SizedBox(
                width: 16,
              ),
              Text(text,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).brightness == Brightness.light
                          ? selected
                              ? AppColors.lightBlack
                              : AppColors.darkGray
                          : selected
                              ? Colors.white
                              : AppColors.greyWhite)),
            ],
          ),
        ),
      ),
    );
  }
}
