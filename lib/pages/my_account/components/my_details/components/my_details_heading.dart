import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../app_configs/app_assets.dart';
import '../../../../../app_configs/app_colors.dart';

class MyDetailsHeading extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;

  const MyDetailsHeading(this.title, {Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: onTap == null
          ? const EdgeInsets.symmetric(vertical: 16)
          : EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          if (onTap != null)
            IconButton(
                onPressed: onTap,
                icon: SvgPicture.asset(
                  AppAssets.editPen,
                  color: Theme.of(context).brightness == Brightness.light
                      ? AppColors.lightBlack
                      : Colors.white,
                ))
        ],
      ),
    );
  }
}
