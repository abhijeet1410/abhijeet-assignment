import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app_configs/app_colors.dart';

class MyAccountTile extends StatelessWidget {
  final VoidCallback? onTap;
  final String asset;
  final String title;

  const MyAccountTile(this.asset, this.title, {Key? key, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: SizedBox(
          child: Row(
            children: [
              SvgPicture.asset(asset,
                  color: Theme.of(context).brightness == Brightness.light
                      ? AppColors.lightBlack
                      : Colors.white),
              const SizedBox(
                width: 15,
              ),
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
