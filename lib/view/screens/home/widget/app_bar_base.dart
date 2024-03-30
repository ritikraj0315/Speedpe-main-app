import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/menu_controller.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/view/base/custom_image.dart';
import 'package:six_cash/view/screens/home/widget/show_balance.dart';
import 'package:six_cash/view/screens/home/widget/show_name.dart';
import '../../../../helper/route_helper.dart';

class AppBarBase extends StatelessWidget implements PreferredSizeWidget {
  const AppBarBase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (profileController) {
      return Container(
        padding: const EdgeInsets.only(
          top: 54,
          left: Dimensions.paddingSizeLarge,
          right: Dimensions.paddingSizeLarge,
          bottom: Dimensions.paddingSizeSmall,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(Dimensions.radiusSizeExtraLarge),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () =>
                      Get.find<MenuItemController>().selectProfilePage(),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 40,
                    width: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: profileController.userInfo == null
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(Images.avatar,
                                    fit: BoxFit.cover),
                              ),
                            )
                          : CustomImage(
                              image:
                                  '${Get.find<SplashController>().configModel!.baseUrls!.customerImageUrl}/${profileController.userInfo!.image ?? ''}',
                              fit: BoxFit.cover,
                              placeholder: Images.avatar,
                            ),
                    ),
                  ),
                ),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Get.find<SplashController>().configModel!.themeIndex == 1
                    ? const ShowName()
                    : ShowBalance(profileController: profileController),
              ],
            ),
            Row(
              children: [
                GetBuilder<SplashController>(builder: (splashController) {
                  bool isRequestMoney = splashController
                      .configModel!.systemFeature!.withdrawRequestStatus!;
                  return isRequestMoney ? const SizedBox() : const SizedBox();
                }),
                const SizedBox(
                  width: Dimensions.paddingSizeSmall,
                ),
                GestureDetector(
                    onTap: () =>
                        Get.toNamed(RouteHelper.getNotificationScreenRoute()),
                    child: Container(
                      width: Get.width * 0.11,
                      height: Get.width * 0.11,
                      padding: EdgeInsets.all(Get.width * 0.025),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).cardColor,
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context)
                                  .highlightColor
                                  .withOpacity(0.1),
                              blurRadius: 40,
                              offset: const Offset(0, 4))
                        ],
                      ),
                      child: profileController.userInfo != null
                          ? SizedBox(
                              height: Dimensions.paddingSizeLarge,
                              width: Dimensions.paddingSizeLarge,
                              child: Image.asset(
                                Images.notificationIcon,
                                color: Theme.of(context).indicatorColor,
                              ),
                            )
                          : SizedBox(
                              height: Dimensions.paddingSizeLarge,
                              width: Dimensions.paddingSizeLarge,
                              child: Image.asset(
                                Images.notificationIcon,
                                color: Theme.of(context).indicatorColor,
                              ),
                            ),
                    )),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(RouteHelper.getSearchServiceRoute()),
                  child: Container(
                    width: Get.width * 0.11,
                    height: Get.width * 0.11,
                    padding: EdgeInsets.all(Get.width * 0.025),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).cardColor,
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context)
                                .highlightColor
                                .withOpacity(0.1),
                            blurRadius: 40,
                            offset: const Offset(0, 4))
                      ],
                    ),
                    child: profileController.userInfo != null
                        ? SizedBox(
                            height: Dimensions.paddingSizeLarge,
                            width: Dimensions.paddingSizeLarge,
                            child: Image.asset(
                              Images.searchIcon,
                              color: Theme.of(context).indicatorColor,
                            ),
                          )
                        : SizedBox(
                            height: Dimensions.paddingSizeLarge,
                            width: Dimensions.paddingSizeLarge,
                            child: Image.asset(
                              Images.searchIcon,
                              color: Theme.of(context).indicatorColor,
                            ),
                          ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    });
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 200);
}
