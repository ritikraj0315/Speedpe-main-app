import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/home_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/screens/wallet_manage/widget/shimmer/card_shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../controller/profile_screen_controller.dart';
import '../cards/add_card.dart';
import '../controller/card_controller.dart';

class CardListView extends StatelessWidget {
  const CardListView({Key? key}) : super(key: key);

  String _formatCardNumber(String value) {
    String cleanedText = value.replaceAll(RegExp(r'\D'), '');
    if (cleanedText.length <= 8) {
      return cleanedText;
    }
    String firstFourDigits = cleanedText.substring(0, 4);
    String lastFourDigits = cleanedText.substring(cleanedText.length - 4);
    String middleDigits = 'XXXX XXXX';
    return '$firstFourDigits $middleDigits $lastFourDigits';
  }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GetBuilder<SplashController>(builder: (splashController) {
      return splashController.configModel!.systemFeature!.bannerStatus!
          ? GetBuilder<CardController>(builder: (controller) {
              return controller.cardList == null
                  ? const Center(child: CardShimmer())
                  : controller.cardList!.isNotEmpty
                      ? Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: Dimensions.paddingSizeLarge),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radiusSizeSmall),
                              color: Theme.of(context).cardColor,
                              border: Border.all(
                                  color: Theme.of(context)
                                      .highlightColor
                                      .withOpacity(0.1),
                                  width: 0.8,
                                  style: BorderStyle.solid),
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context)
                                        .highlightColor
                                        .withOpacity(0.01),
                                    blurRadius: 40,
                                    offset: const Offset(0, 4))
                              ]),
                          child: Column(
                            children: [
                              Container(
                                //width: MediaQuery.sizeOf(context).width * .78,
                                height: 40.0,
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(
                                            Dimensions.radiusSizeSmall),
                                        bottom: Radius.circular(
                                            Dimensions.radiusSizeSmall)),
                                    color: Theme.of(context).cardColor),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(() =>  const AddCardScreen());
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal:
                                              Dimensions.paddingSizeDefault,
                                        ),
                                        child: GetBuilder<ProfileController>(
                                            builder: (profileController) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Cards'.tr,
                                                    style:
                                                        walsheimMedium.copyWith(
                                                      color: Theme.of(context)
                                                          .focusColor,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        }),
                                      ),
                                    ),
                                    //const Spacer(),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(1.5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
                                            gradient: LinearGradient(
                                              colors: [
                                                ColorResources.blueButtonGradientColor,     // Start color
                                                ColorResources.orangeButtonGradientColor,     // Mid 1 color
                                                ColorResources.pinkButtonGradientColor,   // Mid 2 color
                                                ColorResources.purpleButtonGradientColor,  // End color
                                              ],
                                              begin: Alignment.topLeft,    // Gradient start position
                                              end: Alignment.bottomRight,  // Gradient end position
                                              stops: const [0.0, 0.33, 0.66, 1.0], // Position stops for each color
                                            ),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
                                              color: Theme.of(context).cardColor,
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                Get.to(() => const AddCardScreen());
                                              },
                                              child: Container(
                                                height: 35,
                                                padding: const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(Dimensions.radiusSizeSmall),
                                                    color: Theme.of(context).cardColor,
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Theme.of(context)
                                                              .highlightColor
                                                              .withOpacity(0.01),
                                                          blurRadius: 40,
                                                          offset:
                                                          const Offset(0, 4))
                                                    ]),
                                                alignment: Alignment.center,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Add Card",
                                                      style:
                                                      walsheimMedium.copyWith(
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ), // Your actual widget here
                                          ),
                                        ),


                                        const SizedBox(
                                          width: 20,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Stack(
                                children: [
                                  SizedBox(
                                    height: size.width / 1.9,
                                    width: size.width,
                                    child: CarouselSlider.builder(
                                      itemCount: controller.cardList!.length,
                                      itemBuilder: (context, index, realIndex) {
                                        final image = controller
                                                .cardList!.isNotEmpty
                                            ? controller.cardList![index].image
                                            : '';
                                        String? decryptedCardDetails = controller.cardList![index].encryptedCardDetails;
                                        List<String>? cardDetails = decryptedCardDetails?.split('::');
                                        String cardNumber = cardDetails?[0] ?? 'Not available';
                                        String cardHName = cardDetails?[2] ?? 'nil';
                                        return InkWell(
                                          onTap: () {},
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 0),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              padding: const EdgeInsets.all(25),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      '${Get.find<SplashController>().configModel!.baseUrls!.bannerImageUrl}/$image'),
                                                  fit: BoxFit.cover,
                                                  // You can adjust the fit as needed
                                                  //placeholder: AssetImage('assets/placeholder.png'), // Placeholder image
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    cardHName.toUpperCase(),
                                                    style:
                                                        walsheimMedium.copyWith(
                                                      color: Theme.of(context)
                                                          .focusColor,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    _formatCardNumber(cardNumber),
                                                    style:
                                                        walsheimMedium.copyWith(
                                                      color: Theme.of(context)
                                                          .focusColor,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          Get.to(() =>
                                                              const AddCardScreen());
                                                        },
                                                        child: Container(
                                                          height: 30,
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                                  10, 5, 10, 5),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              gradient: LinearGradient(
                                                                colors: [
                                                                  ColorResources.blueButtonGradientColor,     // Start color
                                                                  ColorResources.orangeButtonGradientColor,     // Mid 1 color
                                                                  ColorResources.pinkButtonGradientColor,   // Mid 2 color
                                                                  ColorResources.purpleButtonGradientColor,  // End color
                                                                ],
                                                                begin: Alignment.topLeft,    // Gradient start position
                                                                end: Alignment.bottomRight,  // Gradient end position
                                                                stops: const [0.0, 0.33, 0.66, 1.0], // Position stops for each color
                                                              ),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .highlightColor
                                                                        .withOpacity(
                                                                            0.01),
                                                                    blurRadius:
                                                                        40,
                                                                    offset:
                                                                        const Offset(
                                                                            0,
                                                                            4))
                                                              ]),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                "Manage Card",
                                                                style: walsheimRegular.copyWith(
                                                                    fontSize:
                                                                        11,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .focusColor),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      options: CarouselOptions(
                                        autoPlay: true,
                                        enlargeCenterPage: true,
                                        autoPlayInterval:
                                            const Duration(seconds: 10),
                                        viewportFraction: 1,
                                        onPageChanged: (index, reason) {
                                          Get.find<HomeController>()
                                              .indicateCardIndex(index);
                                        },
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    left: 0,
                                    right: 0,
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: AnimatedSmoothIndicator(
                                        activeIndex: Get.find<HomeController>()
                                            .activeCardIndicator,
                                        count: Get.find<CardController>()
                                            .cardList!
                                            .length,
                                        effect: CustomizableEffect(
                                          dotDecoration: DotDecoration(
                                            height: 5,
                                            width: 5,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.red.withOpacity(0.37),
                                          ),
                                          activeDotDecoration:
                                              const DotDecoration(
                                            height: 7,
                                            width: 7,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ))
                      : const SizedBox();
            })
          : SizedBox(
              child: Text(
                "hello",
                style: walsheimRegular.copyWith(color: Colors.red),
              ),
            );
    });
  }
}
