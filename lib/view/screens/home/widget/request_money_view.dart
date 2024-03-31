import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/banner_controller.dart';
import 'package:six_cash/controller/home_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/view/screens/home/widget/shimmer/banner_shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../controller/requested_money_controller.dart';
import '../../../../helper/price_converter.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/styles.dart';
import '../../../base/animated_custom_dialog.dart';
import '../../requested_money/widget/confirmation_dialog.dart';

class RequestMoneyView extends StatelessWidget {
  const RequestMoneyView({Key? key}) : super(key: key);

  String maskPhoneNumber(String phoneNumber) {
    if (phoneNumber.length <= 4) {
      return phoneNumber;
    }
    String masked = phoneNumber.substring(0, 2); // Keep first two digits
    for (int i = 2; i < phoneNumber.length - 2; i++) {
      masked += 'X';
    }
    masked +=
        phoneNumber.substring(phoneNumber.length - 2); // Keep last two digits
    return masked;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextEditingController reqPasswordController = TextEditingController();
    return GetBuilder<SplashController>(builder: (splashController) {
      return splashController.configModel!.systemFeature!.bannerStatus!
          ? GetBuilder<RequestedMoneyController>(
              builder: (requestMoneyController) {
              return requestMoneyController.pendingRequestedMoneyList == null
                  ? const Center(child: BannerShimmer())
                  : requestMoneyController.pendingRequestedMoneyList.isNotEmpty
                      ? Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: Dimensions.marginSizeDefault),
                          child: Column(
                            children: [
                              Container(
                                height: size.width / 5.5,
                                width: size.width,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(
                                            Dimensions.radiusSizeDefault),
                                        bottom: Radius.circular(
                                            Dimensions.radiusSizeDefault)),
                                    color: Theme.of(context).cardColor),
                                child: CarouselSlider.builder(
                                  itemCount: requestMoneyController
                                      .pendingRequestedMoneyList.length,
                                  itemBuilder: (context, index, realIndex) {
                                    final name = requestMoneyController
                                        .pendingRequestedMoneyList[index]
                                        .sender!
                                        .name;
                                    final number = maskPhoneNumber(
                                        requestMoneyController
                                            .pendingRequestedMoneyList[index]
                                            .sender!
                                            .phone!
                                            .replaceAll("+91", ""));
                                    final amount = requestMoneyController
                                        .pendingRequestedMoneyList[index]
                                        .amount;
                                    return InkWell(
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal:
                                                Dimensions.paddingSizeSmall),
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(Dimensions
                                                        .radiusSizeDefault)),
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        'Requested by ${'$name'.toUpperCase()}',
                                                        style: walsheimRegular
                                                            .copyWith(
                                                                color: Theme.of(
                                                                        context)
                                                                    .focusColor
                                                                    .withOpacity(
                                                                        0.8),
                                                                fontSize: 12)),
                                                    Text(number,
                                                        style: walsheimLight
                                                            .copyWith(
                                                                color: Theme.of(
                                                                        context)
                                                                    .focusColor
                                                                    .withOpacity(
                                                                        0.5),
                                                                fontSize: 11)),
                                                  ],
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    showAnimatedDialog(
                                                        context,
                                                        ConfirmationDialog(
                                                            passController:
                                                                reqPasswordController,
                                                            icon: Images
                                                                .successIcon,
                                                            isAccept: true,
                                                            description:
                                                                '${'are_you_sure_want_to_accept'.tr} \n ${requestMoneyController.pendingRequestedMoneyList[index].sender!.name!} \n ${requestMoneyController.pendingRequestedMoneyList[index].sender!.phone!}',
                                                            onYesPressed: () {
                                                              Get.find<RequestedMoneyController>().acceptRequest(
                                                                  context,
                                                                  requestMoneyController
                                                                      .pendingRequestedMoneyList[
                                                                          index]
                                                                      .id,
                                                                  reqPasswordController
                                                                      .text
                                                                      .trim());
                                                            }),
                                                        dismissible: false,
                                                        isFlip: true);
                                                  },
                                                  child: Container(
                                                    height: 30,
                                                    padding: const EdgeInsets
                                                        .fromLTRB(10, 0, 10, 0),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(Dimensions
                                                              .radiusSizeSmall),
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          ColorResources
                                                              .blueButtonGradientColor,
                                                          ColorResources
                                                              .orangeButtonGradientColor,
                                                          ColorResources
                                                              .pinkButtonGradientColor,
                                                          ColorResources
                                                              .purpleButtonGradientColor,
                                                        ],
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                        stops: const [
                                                          0.0,
                                                          0.33,
                                                          0.66,
                                                          1.0
                                                        ], // Position stops for each color
                                                      ),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            '${'PAY'.tr} ${PriceConverter.balanceWithSymbol(balance: amount.toString())}',
                                                            style: walsheimRegular.copyWith(
                                                                color: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleLarge!
                                                                    .color,
                                                                fontSize: Dimensions
                                                                    .fontSizeSmall)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),
                                    );
                                  },
                                  options: CarouselOptions(
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                    autoPlayInterval:
                                        const Duration(seconds: 15),
                                    viewportFraction: 1,
                                    onPageChanged: (index, reason) {
                                      Get.find<HomeController>()
                                          .indicateIndex(index);
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Positioned(
                                bottom: 10,
                                left: 0,
                                right: 0,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: AnimatedSmoothIndicator(
                                    activeIndex: Get.find<HomeController>()
                                        .activeIndicator,
                                    count: Get.find<BannerController>()
                                        .bannerList!
                                        .length,
                                    effect: CustomizableEffect(
                                      dotDecoration: DotDecoration(
                                        height: 5,
                                        width: 5,
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white.withOpacity(0.37),
                                      ),
                                      activeDotDecoration: const DotDecoration(
                                        height: 7,
                                        width: 7,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
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
