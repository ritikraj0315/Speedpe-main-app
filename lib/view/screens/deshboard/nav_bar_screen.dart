import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/controller/menu_controller.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/view/base/animated_custom_dialog.dart';
import 'package:six_cash/view/base/logout_dialog.dart';
import 'package:six_cash/view/screens/splash/splash_screen.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({Key? key}) : super(key: key);

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    Get.find<MenuItemController>().selectHomePage(isUpdate: false);

    Get.find<AuthController>().checkBiometricWithPin();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: GetBuilder<MenuItemController>(builder: (menuController) {
        return Scaffold(
          //backgroundColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
          body:
              PageStorage(bucket: bucket, child: menuController.currentScreen),
          // floatingActionButton: UnicornOutlineButton(
          //   strokeWidth: 1.5,
          //   radius: 50,
          //   gradient: LinearGradient(
          //     colors: [
          //       Theme.of(context).primaryColor,
          //       Theme.of(context).primaryColor.withOpacity(0.5),
          //       Theme.of(context).primaryColor.withOpacity(0.3),
          //       Theme.of(context).primaryColor.withOpacity(0.05),
          //       Theme.of(context).primaryColor.withOpacity(0),
          //     ],
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter,
          //   ),
          //   child: FloatingActionButton(
          //     backgroundColor: Theme.of(context).primaryColor,
          //     elevation: 1,
          //     onPressed: () => Get.to(() => const CameraScreen(
          //           fromEditProfile: false,
          //           isBarCodeScan: true,
          //           isHome: true,
          //         )),
          //     child: Padding(
          //       padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          //       child: Image.asset(
          //         Images.scannerIcon,
          //         color: Theme.of(context).indicatorColor,
          //       ),
          //     ),
          //   ),
          // ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Container(
              height: 70,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorResources.getBlackAndWhite().withOpacity(0.14),
                    blurRadius: 80,
                    offset: const Offset(0, 20),
                  ),
                  BoxShadow(
                    color: ColorResources.getDarkGrayColor().withOpacity(0.20),
                    blurRadius: 0.5,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customBottomItem(
                      tap: () => menuController.selectHomePage(),
                      icon: menuController.currentTab == 0
                          ? Images.homeIconBold
                          : Images.homeIcon,
                      name: 'home'.tr,
                      selectIndex: 0,
                    ),
                    customBottomItem(
                      tap: () => menuController.selectHistoryPage(),
                      icon: menuController.currentTab == 1
                          ? Images.activityIcon
                          : Images.activityIcon,
                      name: 'Activity'.tr,
                      selectIndex: 1,
                    ),
                    //const SizedBox(height: 20, width: 20),
                    customBottomItem(
                      tap: () => menuController.selectNotificationPage(),
                      icon: menuController.currentTab == 2
                          ? Images.compassSquareIcon
                          : Images.compassSquareIcon,
                      name: 'Explore'.tr,
                      selectIndex: 2,
                    ),
                    customBottomItem(
                      tap: () => menuController.selectProfilePage(),
                      icon: menuController.currentTab == 3
                          ? Images.menuIcon
                          : Images.menuIcon,
                      name: 'More'.tr,
                      selectIndex: 3,
                    ),
                  ],
                ),
              )),
        );
      }),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    showAnimatedDialog(
        context,
        CustomDialog(
          icon: Icons.exit_to_app_rounded,
          title: 'exit'.tr,
          description: 'do_you_want_to_exit_the_app'.tr,
          onTapFalse: () => Navigator.of(context).pop(false),
          onTapTrue: () {
            SystemNavigator.pop()
                .then((value) => Get.offAll(() => const SplashScreen()));
          },
          onTapTrueText: 'yes'.tr,
          onTapFalseText: 'no'.tr,
        ),
        dismissible: false,
        isFlip: true);
    return true;
  }

  Widget customBottomItem(
      {required String icon,
      required String name,
      VoidCallback? tap,
      int? selectIndex}) {
    return InkWell(
        onTap: tap,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Get.find<MenuItemController>().currentTab == selectIndex
              ? SizedBox(
                  height: 20,
                  width: Dimensions.fontSizeExtraLarge,
                  child: Image.asset(
                    icon,
                    color: Theme.of(context).primaryColor, // Color of the icon
                  ),
                )
              : SizedBox(
                  height: 20,
                  width: Dimensions.fontSizeExtraLarge,
                  child: Image.asset(
                    icon,
                    fit: BoxFit.contain,
                    color:
                        Get.find<MenuItemController>().currentTab == selectIndex
                            ? Theme.of(context).primaryColor
                            : ColorResources.nevDefaultColor,
                  ),
                ),
          SizedBox(
            height: 6.0,
            child: Container(
              color: Colors.red,
            ),
          ),
          Text(name,
              style: TextStyle(
                color: Get.find<MenuItemController>().currentTab == selectIndex
                    ? Theme.of(context).primaryColor
                    : ColorResources.nevDefaultColor,
                fontSize: Dimensions.fontSizeSmall,
                fontWeight: FontWeight.w400,
              ))
        ]));
  }
}
