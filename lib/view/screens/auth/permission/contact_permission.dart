import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../util/styles.dart';
import '../../../../controller/auth_controller.dart';
import '../../../../controller/splash_controller.dart';
import '../../../../controller/transaction_controller.dart';
import '../../../../data/model/response/user_data.dart';
import '../../../../helper/route_helper.dart';
import '../../../../util/images.dart';

class ContactPermissionScreen extends StatefulWidget {
  const ContactPermissionScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ContactPermissionScreen> createState() =>
      _ContactPermissionScreenState();
}

class _ContactPermissionScreenState extends State<ContactPermissionScreen> {
  Future<void> setContactPermissionAttempt(String value) async {
    //true or false (default will be false)
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('contactPermissionAttempt', value);
  }

  Future<void> _proceedWithPermission() async {
    await Get.find<TransactionMoneyController>().fetchContact().then((_) {
      Get.find<SplashController>().getConfigData().then((value) {
        if (value.isOk) {
          Get.find<SplashController>().initSharedData().then((value) {
            UserData? userData = Get.find<AuthController>().getUserData();

            if (userData != null &&
                (Get.find<SplashController>().configModel!.companyName !=
                    null)) {
              Get.offNamed(RouteHelper.getLoginRoute(
                countryCode: userData.countryCode,
                phoneNumber: userData.phone,
              ));
            } else {
              Get.offNamed(RouteHelper.getChoseLoginRegRoute());
            }
          });
        }
      });
    });
  }

  Future<void> _proceedWithoutPermission() async {
    Get.find<SplashController>().getConfigData().then((value) {
      if (value.isOk) {
        Get.find<SplashController>().initSharedData().then((value) {
          UserData? userData = Get.find<AuthController>().getUserData();

          if (userData != null &&
              (Get.find<SplashController>().configModel!.companyName != null)) {
            Get.offNamed(RouteHelper.getLoginRoute(
              countryCode: userData.countryCode,
              phoneNumber: userData.phone,
            ));
          } else {
            Get.offNamed(RouteHelper.getChoseLoginRegRoute());
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Image.asset(
                    Images.contactIcon,
                    height: 50,
                    width: 50,
                    // You can set other properties such as width, height, etc.
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Allow SpeedPe to access\nyour contacts'.tr,
                  textAlign: TextAlign.start,
                  style: walsheimBold.copyWith(
                    color: Theme.of(context).focusColor,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "• How you'll use this".tr,
                          textAlign: TextAlign.start,
                          style: walsheimMedium.copyWith(
                            color: Theme.of(context).focusColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'This will help you to hassle free money\ntransfer with friends, family etc'
                              .tr,
                          textAlign: TextAlign.start,
                          style: walsheimLight.copyWith(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "• How we'll use this".tr,
                          textAlign: TextAlign.start,
                          style: walsheimMedium.copyWith(
                            color: Theme.of(context).focusColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'To notify you when your friend,\nfamily joins SpeedPe.'
                              .tr,
                          textAlign: TextAlign.start,
                          style: walsheimLight.copyWith(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "• You're always in control".tr,
                          textAlign: TextAlign.start,
                          style: walsheimMedium.copyWith(
                            color: Theme.of(context).focusColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'You can change this anytime in the\nsettings.'.tr,
                          textAlign: TextAlign.start,
                          style: walsheimLight.copyWith(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  onPressed: () {
                    _proceedWithPermission();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Theme.of(context).indicatorColor, backgroundColor: Theme.of(context).primaryColor, padding: const EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 8,
                  ),
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      "Allow",
                      style: walsheimMedium.copyWith(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _proceedWithoutPermission();
                    setContactPermissionAttempt("true");
                  },
                  child: Container(
                    height: 55,
                    alignment: Alignment.center,
                    child: Text(
                      "Maybe Later",
                      style: walsheimMedium.copyWith(
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool?> getBackScreen() async {
  Get.offAndToNamed(RouteHelper.navbar, arguments: false);
  return null;
}
