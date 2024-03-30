import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/banner_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/view/base/custom_image.dart';
import 'package:six_cash/view/screens/add_money/web_screen.dart';
import 'package:six_cash/view/screens/home/widget/shimmer/banner_shimmer.dart';

import '../../../../data/model/banner_model.dart';
import '../../../../util/styles.dart';
import '../kyc_verify_screen.dart';

class KycMethodView extends StatelessWidget {
  const KycMethodView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (splashController) {
      return splashController.configModel!.systemFeature!.bannerStatus!
          ? GetBuilder<BannerController>(builder: (controller) {
              List<BannerModel> topBannerList =
                  controller.getHomeBanners('kyc_method').reversed.toList();
              return topBannerList == null
                  ? const Center(child: BannerShimmer())
                  : topBannerList.isNotEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  Dimensions.paddingSizeDefault,
                                  20,
                                  Dimensions.paddingSizeDefault,
                                  0),
                              child: Text(
                                "Select a method to setup your account:",
                                style: walsheimMedium.copyWith(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.9),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 200,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: topBannerList.length,
                                itemBuilder: (context, index) {
                                  final image = topBannerList.isNotEmpty
                                      ? topBannerList[index].image
                                      : '';
                                  return GestureDetector(
                                    onTap: () {
                                      if (topBannerList.isNotEmpty) {
                                        Get.to(KycVerifyScreen(methodName: topBannerList[index].title!));
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          Dimensions.paddingSizeDefault,
                                          0,
                                          Dimensions.paddingSizeDefault,
                                          15),
                                      child: Container(
                                          height: 70,
                                          decoration: BoxDecoration(
                                              color:
                                                  Theme.of(context).cardColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions
                                                          .radiusSizeDefault)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 15,
                                                            right: 15),
                                                    height: 50,
                                                    width: 50,
                                                    child: CustomImage(
                                                        image:
                                                            "${Get.find<SplashController>().configModel!.baseUrls!.bannerImageUrl}/$image",
                                                        fit: BoxFit.cover,
                                                        placeholder: Images
                                                            .bannerPlaceHolder),
                                                  ),
                                                  Text(
                                                    topBannerList[index].title!,
                                                    style:
                                                        walsheimMedium.copyWith(
                                                      fontSize: 15,
                                                      color: Theme.of(context)
                                                          .focusColor
                                                          .withOpacity(0.8),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  if (topBannerList
                                                      .isNotEmpty) {
                                                    Get.to(WebScreen(
                                                        selectedUrl:
                                                            topBannerList[index]
                                                                .url!));
                                                  }
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  margin: const EdgeInsets.only(
                                                      left: 15, right: 15),
                                                  height: 50,
                                                  width: 50,
                                                  child: Image.asset(
                                                    Images.infoIcon,
                                                    color: Theme.of(context)
                                                        .primaryColor
                                                        .withOpacity(0.7),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      : const SizedBox();
            })
          : const SizedBox();
    });
  }
}
