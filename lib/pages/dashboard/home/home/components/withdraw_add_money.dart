import 'package:flutter/material.dart';
import 'package:assignment_pay/app_configs/app_assets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../app_configs/app_colors.dart';

class WithDrawAddMoney extends StatelessWidget {
  final VoidCallback? onWithdrawPressed;
  final VoidCallback? onAddMoneyPressed;

  const WithDrawAddMoney(
      {Key? key, this.onWithdrawPressed, this.onAddMoneyPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
          onPressed: onWithdrawPressed,
          label: const Text(
            "Withdraw Money",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.brightBackground),
          ),
          icon: SvgPicture.asset(
            AppAssets.withdrawVector,
            color: AppColors.brightBackground,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: TextButton.icon(
              onPressed: onAddMoneyPressed,
              label: const Text(
                "Add Money",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.brightBackground),
              ),
              icon: const Icon(
                Icons.add,
                color: AppColors.brightBackground,
              )),
        ),
      ],
    );
  }
}
