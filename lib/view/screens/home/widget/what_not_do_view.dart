import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/banner_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/view/screens/add_money/web_screen.dart';
import 'package:six_cash/view/screens/home/widget/shimmer/banner_shimmer.dart';
import '../../../../data/model/banner_model.dart';
import '../../../../util/styles.dart';

class WhatNotDoView extends StatelessWidget {
  const WhatNotDoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GetBuilder<SplashController>(builder: (splashController) {
      return splashController.configModel!.systemFeature!.bannerStatus!
          ? GetBuilder<BannerController>(builder: (controller) {
              List<BannerModel> topBannerList =
                  controller.getHomeBanners('what_not_do');
              return topBannerList == null
                  ? const Center(child: BannerShimmer())
                  : topBannerList.isNotEmpty
                      ? Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: Dimensions.marginSizeDefault),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Reminder from SpeedPe",
                                style: walsheimBold.copyWith(
                                  fontSize: 18,
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.9),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                height: size.width / 3.5,
                                width: size.width,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: topBannerList.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          if (topBannerList.isNotEmpty) {
                                            Get.to(WebScreen(
                                                selectedUrl:
                                                    topBannerList[index].url!));
                                          }
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        15, 0, 15, 0),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    200,
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .cardColor,
                                                    border: Border.all(
                                                        color: Theme.of(context)
                                                            .focusColor
                                                            .withOpacity(0.3),
                                                        width: 0.5),
                                                    borderRadius: BorderRadius
                                                        .circular(Dimensions
                                                            .radiusSizeDefault)),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      topBannerList[index]
                                                          .title!,
                                                      style: walsheimLight
                                                          .copyWith(
                                                        fontSize: 14,
                                                        color: Theme.of(context)
                                                            .focusColor
                                                            .withOpacity(0.5),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                            const SizedBox(
                                              width: 20,
                                            )
                                          ],
                                        ));
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox();
            })
          : const SizedBox();
    });
  }
}
