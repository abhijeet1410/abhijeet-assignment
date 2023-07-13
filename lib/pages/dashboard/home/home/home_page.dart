import 'package:assignment_pay/pages/dashboard/home/home/pay_receive_bank_card.dart';
import 'package:assignment_pay/pages/dashboard/payment/payment_transfer_page.dart';
import 'package:assignment_pay/pages/my_account/pages/my_account_page.dart';
import 'package:assignment_pay/widgets/sliding_up_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:assignment_pay/app_configs/app_assets.dart';
import 'package:assignment_pay/app_configs/app_colors.dart';
import 'package:assignment_pay/utils/shared_preference_helper.dart';
import 'package:assignment_pay/widgets/alert_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../global_controllers/user_controller.dart';
import '../../../../widgets/alert_sheet.dart';
import '../../../../widgets/user_circle_avatar.dart';
import '../../../base_page.dart';
import '../../controllers/dashboard_controller.dart';

class HomePage extends BasePage {
  static const routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends BasePageState<HomePage> with TickerProviderStateMixin {
  late UserController _controller;
  final PanelController _panelController = PanelController();
  late DashboardController _dashboardController;
  late RefreshController _refreshController;
  late AnimationController _animController;
  late Animation<Offset> _animation;
  late AnimationController _aController;
  late Animation<Offset> _anim;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<UserController>();
    _refreshController = RefreshController();
    _dashboardController = Get.isRegistered<DashboardController>()
        ? Get.find<DashboardController>()
        : Get.put(DashboardController());
    _animController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..forward();
    _animation = Tween<Offset>(begin: const Offset(-1.0, 1.0), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _animController, curve: Curves.bounceInOut));
    _aController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..forward();
    _anim = Tween<Offset>(begin: const Offset(0, -100.0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _aController, curve: Curves.bounceIn));
  }

  @override
  Widget body(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        if (_panelController.isPanelOpen) {
          _panelController.close();
          return false;
        } else {
          showAppAlertDialog(
                  title: 'Close App',
                  description: 'Do you want to exit from VePay?',
                  positiveText: 'Yes',
                  negativeText: 'No')
              .then((value) {
            if (value!) {
              SystemNavigator.pop();
              return true;
            }
          });
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.darkBlue,
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          controller: _refreshController,
          onRefresh: () async {
            _refreshController.refreshCompleted();
          },
          child: SafeArea(
            child: SlidingUpPanel(
              maxHeight: Get.height,
              minHeight: Get.height / 2,
              parallaxEnabled: true,
              parallaxOffset: .5,
              color: theme.canvasColor,
              controller: _panelController,
              onPanelOpened: () {
                setState(() {});
              },
              onPanelClosed: () {
                setState(() {});
              },
              extraChildren: [
                Stack(children: [
                  SvgPicture.asset(
                    AppAssets.homePageBackground,
                    fit: BoxFit.fill,
                    width: Get.width,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: Get.width,
                          margin: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: (() =>
                                      Get.toNamed(MyAccountPage.routeName)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Hello, ${SharedPreferenceHelper.user!.user!.firstName}!",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.brightBackground),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      const Text(
                                        "@user",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.brightBackground),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){},
                                child: SvgPicture.asset(
                                  AppAssets.bell,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppAssets.walletVector,
                                color: AppColors.brightBackground,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              const Text(
                                "Wallet Balance",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.brightBackground),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "₹ 1120",
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                                color: AppColors.brightBackground),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                },
                                child: SlideTransition(
                                  position: _animation,
                                  transformHitTests: true,
                                  textDirection: TextDirection.ltr,
                                  child: Container(
                                    height: 48,
                                    decoration: BoxDecoration(
                                        color: context.isDarkMode
                                            ? AppColors.lightPurple
                                            : AppColors.brightPrimary,
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(32),
                                          bottomRight: Radius.circular(32),
                                        )),
                                    child: const Center(
                                      child: Text(
                                        "Withdraw Money",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.brightBackground),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                },
                                child: SlideTransition(
                                  position: _animation,
                                  transformHitTests: true,
                                  textDirection: TextDirection.rtl,
                                  child: Container(
                                    height: 48,
                                    decoration: BoxDecoration(
                                        color: context.isDarkMode
                                            ? AppColors.lightPurple
                                            : AppColors.brightPrimary,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(40.0),
                                          bottomLeft: Radius.circular(40.0),
                                        )),
                                    child: const Center(
                                      child: Text(
                                        "Add Money",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.brightBackground),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ]),
                ]),
              ],
              //body: Container(),
              panelBuilder: (sc) => SingleChildScrollView(
                physics: _panelController.isPanelOpen
                    ? const AlwaysScrollableScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PayReceiveBankCardTile(
                            onTap: () {
                              Get.toNamed(PaymentPage.routeName);
                            },
                            assetImage: AppAssets.sendPaymentVector,
                            text: 'Pay',
                            begin: const Offset(-1, 0),
                          ),
                          PayReceiveBankCardTile(
                            onTap: () {

                            },
                            assetImage: AppAssets.receiveVector,
                            text: 'Invoice',
                            begin: const Offset(-2, 0),
                          ),
                          PayReceiveBankCardTile(
                            onTap: () {},
                            assetImage: AppAssets.bankVector,
                            text: 'Banks',
                            begin: Offset(-3, 0),
                          ),
                          PayReceiveBankCardTile(
                            onTap: () {},
                            assetImage: AppAssets.cardVector,
                            text: 'Cards',
                            begin: const Offset(-4, 0),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 116,
                    )
                  ],
                ),
              ),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32.0),
                  topRight: Radius.circular(32.0)),
            ),
          ),
        ),
      ),
    );
  }
}
