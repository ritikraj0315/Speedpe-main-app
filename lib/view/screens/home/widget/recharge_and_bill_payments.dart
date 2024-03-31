import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';
import 'package:six_cash/view/screens/home/widget/shimmer/web_site_shimmer.dart';

import '../../../../controller/websitelink_controller.dart';
import '../../../../data/model/websitelink_models.dart';
import '../../../../helper/app_routes.dart';
import '../../bill_manage/widget/service_custom_image.dart';

class RechargeAndBillPayments extends StatelessWidget {
  const RechargeAndBillPayments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (splashController) {
      return Stack(children: [
        Positioned(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault,
                  10, Dimensions.paddingSizeDefault, 20),
              child: Row(
                children: [
                  Text(
                    "Recharge & Bill Payments",
                    style: walsheimRegular.copyWith(
                      fontSize: 16,
                      color: Theme.of(context).focusColor.withOpacity(0.9),
                    ),
                  ),

                  SizedBox(
                    height: 18,
                    width: 30,
                    child: Image.asset(Images.bbpsMnemonicLogo),
                  ),
                ],
              ),
            ),

            /// Cards...
            SizedBox(
              //height: 160.0,
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeDefault),
                  child: InkWell(
                    onTap: () {},
                    child: const ExpandableContainer(
                      filterText: "homebills",
                    ),
                  )),
            ),

            //const BannerView(),
          ],
        )),
      ]);
    });
  }
}

class ExpandableContainer extends StatefulWidget {
  final String filterText;

  const ExpandableContainer({Key? key, required this.filterText})
      : super(key: key);

  @override
  State<ExpandableContainer> createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WebsiteLinkController>(builder: (websiteLinkController) {
      List<WebsiteLinkModel> filteredList = websiteLinkController
          .getReversedFilteredWebsiteList(widget.filterText);
      return websiteLinkController.isLoading
          ? const WebSiteShimmer()
          : websiteLinkController.websiteList!.isEmpty
              ? const SizedBox()
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusSizeDefault),
                        color: Theme.of(context).cardColor,
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context)
                                  .highlightColor
                                  .withOpacity(0.01),
                              blurRadius: 40,
                              offset: const Offset(0, 4))
                        ]),
                    height: isExpanded ? 230.0 : 120.0,
                    child: Stack(
                      children: [
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: 0.8,
                          ),
                          itemCount: filteredList.length,
                          itemBuilder: (context, index) {
                            return CustomInkWell(
                              onTap: () {
                                AppRoutes.openScreen(filteredList[index].url!);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.radiusSizeSmall,
                                  ),
                                  //color: Theme.of(context).cardColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context)
                                          .cardColor
                                          .withOpacity(0.01),
                                      blurRadius: 40,
                                      offset: const Offset(0, 4),
                                    )
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: ClipRRect(
                                        child: ServiceCustomImage(
                                          image:
                                              "${Get.find<SplashController>().configModel!.baseUrls!.linkedWebsiteImageUrl}/${filteredList[index].image}",
                                          placeholder:
                                              Images.webLinkPlaceHolder,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      filteredList[index]
                                          .name!
                                          .replaceAll(r'\n', '\n'),
                                      // Replace "\n" with newline character
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      style: walsheimMedium.copyWith(
                                          fontSize: 11,
                                          color:
                                              Theme.of(context).highlightColor),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        Positioned(
                          bottom: 0, // Align at the bottom
                          left: (MediaQuery.of(context).size.width - 77) /
                              2, // Center horizontally
                          child: Image.asset(
                            isExpanded
                                ? Images.upArrowIcon
                                : Images.downArrowIcon,
                            width: 25,
                            height: 25,
                            fit: BoxFit.contain,
                            color: Theme.of(context).indicatorColor,
                          ),
                        ),
                      ],
                    ),
                  ));
    });
  }
}
