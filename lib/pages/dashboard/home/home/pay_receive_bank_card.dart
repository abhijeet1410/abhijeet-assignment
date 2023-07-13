import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:assignment_pay/app_configs/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PayReceiveBankCardTile extends StatefulWidget {
  final String assetImage;
  final String text;
  final VoidCallback? onTap;
  final Offset begin;
  const PayReceiveBankCardTile(
      {Key? key,
      this.onTap,
      required this.assetImage,
      required this.text,
      required this.begin})
      : super(key: key);

  @override
  State<PayReceiveBankCardTile> createState() => _PayReceiveBankCardTileState();
}

class _PayReceiveBankCardTileState extends State<PayReceiveBankCardTile>
    with TickerProviderStateMixin {
  FlipCardController controller = FlipCardController();
  AnimationController? animationController;

  //AnimationController? animationController1;

  Animation? animation;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    // animationController1 =
    //     AnimationController(vsync: this, duration: const Duratiosn(milliseconds: 200));
    animation = ColorTween(
            begin: Colors.transparent,
            end: Get.isDarkMode
                ? AppColors.brightBackground
                : AppColors.brightPrimary)
        .animate(animationController!);
    animation!.addListener(() {
      setState(() {});
    });
    //controller.toggleCard();
    //  animationController!.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.toggleCard();
    //     animationController1!.forward();
    //   }
    // });
    //Timer(const Duration(milliseconds: 200),()=>animationController!.forward());
    animationController!.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: SlideTransition(
        position: Tween<Offset>(begin: widget.begin, end: Offset.zero)
            .animate(animationController!),
        child: FadeTransition(
          opacity: animationController!,
          child: Column(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                    color: animation!.value,
                    // color: Get.isDarkMode
                    //   ? AppColors.brightBackground
                    //   : AppColors.brightPrimary,
                    borderRadius: BorderRadius.circular(16)),
                child: Center(
                  child: SvgPicture.asset(
                    widget.assetImage,
                    color: animation!.value != Colors.transparent
                        ? context.isDarkMode
                            ? AppColors.darkBackground
                            : AppColors.brightBackground
                        : animation!.value,
                    // color: Get.isDarkMode
                    //     ? AppColors.darkBackground
                    //     : AppColors.brightBackground,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                widget.text,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}
