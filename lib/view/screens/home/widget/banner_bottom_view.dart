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

class BannerBottomView extends StatelessWidget {
  const BannerBottomView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GetBuilder<SplashController>(builder: (splashController) {
      return splashController.configModel!.systemFeature!.bannerStatus!
          ? GetBuilder<BannerController>(builder: (controller) {
              List<BannerModel> topBannerList =
                  controller.getHomeBanners('customer_home_bottom');
              return topBannerList == null
                  ? const Center(child: BannerShimmer())
                  : topBannerList.isNotEmpty
                      ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                Dimensions.paddingSizeDefault,
                                20,
                                Dimensions.paddingSizeDefault,
                                0),
                            child: Text(
                              "What's on SpeedPe?",
                              style: walsheimRegular.copyWith(
                                fontSize: 16,
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.9),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: size.width / 3.0,
                            width: size.width,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: topBannerList.length,
                              itemBuilder: (context, index) {
                                final image = topBannerList.isNotEmpty
                                    ? topBannerList[index].image
                                    : '';
                                return InkWell(
                                  onTap: () {
                                    if (topBannerList.isNotEmpty) {
                                      Get.to(WebScreen(
                                          selectedUrl:
                                              topBannerList[index].url!));
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        Dimensions.paddingSizeDefault,
                                        0,
                                        0,
                                        0),
                                    child: Container(
                                      width: MediaQuery.of(context)
                                              .size
                                              .width -
                                          80,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(
                                                  Dimensions
                                                      .radiusSizeDefault)),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                        child: CustomImage(
                                            image:
                                                "${Get.find<SplashController>().configModel!.baseUrls!.bannerImageUrl}/$image",
                                            fit: BoxFit.cover,
                                            placeholder:
                                                Images.bannerPlaceHolder),
                                      ),
                                    ),
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
