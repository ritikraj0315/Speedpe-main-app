import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/controller/websitelink_controller.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';
import 'package:six_cash/view/screens/add_money/web_screen.dart';
import 'package:six_cash/view/screens/home/widget/shimmer/web_site_shimmer.dart';

import '../../../../data/model/websitelink_models.dart';
import '../../../base/explore_custom_image.dart';

class LinkedWebsite extends StatelessWidget {
  const LinkedWebsite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (splashController) {
      return splashController.configModel!.systemFeature!.linkedWebSiteStatus!
          ? GetBuilder<WebsiteLinkController>(builder: (websiteLinkController) {
              List<WebsiteLinkModel> filteredList =
                  websiteLinkController.getFilteredWebsiteList("ad");
              return websiteLinkController.isLoading
                  ? const WebSiteShimmer()
                  : websiteLinkController.websiteList!.isEmpty
                      ? const SizedBox()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  Dimensions.paddingSizeDefault,
                                  20,
                                  Dimensions.paddingSizeDefault,
                                  0),
                              child: Text(
                                "Explore with SpeedPe",
                                style: walsheimRegular.copyWith(
                                  fontSize: 16,
                                  color: Theme.of(context).focusColor.withOpacity(0.9),
                                ),
                              ),
                            ),
                            Container(
                              height: 110,
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                  top: Dimensions.paddingSizeSmall),
                              decoration: BoxDecoration(
                                // color: Theme.of(context).colorScheme.background,
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorResources.containerShedow
                                        .withOpacity(0.05),
                                    blurRadius: 20,
                                    offset: const Offset(0, 3),
                                  )
                                ],
                              ),
                              child: ListView.builder(
                                itemCount: filteredList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return CustomInkWell(
                                    onTap: () => Get.to(WebScreen(
                                        selectedUrl: filteredList[index].url!)),
                                    radius: Dimensions.radiusSizeExtraSmall,
                                    highlightColor: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.1),
                                    child: Container(
                                      width: 90,
                                      padding: const EdgeInsets.symmetric(
                                          vertical:
                                              Dimensions.paddingSizeDefault),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions
                                                          .radiusSizeSmall),
                                              child: ExploreCustomImage(
                                                image:
                                                    "${Get.find<SplashController>().configModel!.baseUrls!.linkedWebsiteImageUrl}/${filteredList[index].image}",
                                                placeholder:
                                                    Images.webLinkPlaceHolder,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            filteredList[index].name!,
                                            style: sFProDisplayMedium.copyWith(
                                              fontSize: 11,
                                              color: Theme.of(context)
                                                  .highlightColor,
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
                        );
            })
          : const SizedBox();
    });
  }
}
