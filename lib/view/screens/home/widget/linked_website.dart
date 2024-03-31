import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/controller/websitelink_controller.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/screens/add_money/web_screen.dart';
import 'package:six_cash/view/screens/home/widget/shimmer/web_site_shimmer.dart';
import '../../../base/explore_custom_image.dart';

class LinkedWebsite extends StatelessWidget {
  const LinkedWebsite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (splashController) {
      return splashController.configModel!.systemFeature!.linkedWebSiteStatus!
          ? GetBuilder<WebsiteLinkController>(builder: (websiteLinkController) {
              return websiteLinkController.isLoading
                  ? const WebSiteShimmer()
                  : websiteLinkController.websiteList!.isEmpty
                      ? const SizedBox()
                      : Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: Dimensions.marginSizeDefault),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Explore with SpeedPe",
                                style: walsheimRegular.copyWith(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.9),
                                ),
                              ),
                              SizedBox(
                                height: 110,
                                width: double.infinity,
                                child: ListView.builder(
                                  itemCount:
                                      websiteLinkController.websiteList!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () => Get.to(WebScreen(
                                          selectedUrl: websiteLinkController
                                              .websiteList![index].url!)),
                                      child: Container(
                                        width: 90,
                                        margin: const EdgeInsets.symmetric(
                                            vertical:
                                                Dimensions.marginSizeSmall),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              width: 55,
                                              height: 55,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions
                                                            .radiusSizeSmall),
                                                child: Image.network(
                                                    "${Get.find<SplashController>().configModel!.baseUrls!.linkedWebsiteImageUrl}/${websiteLinkController.websiteList![index].image!}"),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              websiteLinkController
                                                  .websiteList![index].name!,
                                              style: walsheimRegular.copyWith(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .focusColor
                                                    .withOpacity(0.7),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
            })
          : const SizedBox();
    });
  }
}
