import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../controller/splash_controller.dart';
import '../../../util/color_resources.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/styles.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_ink_well.dart';
import '../../base/explore_custom_image.dart';
import '../add_money/web_screen.dart';
import '../home/widget/shimmer/web_site_shimmer.dart';
import 'controller/billmanage_controller.dart';

class AllUtilityServiceScreen extends StatefulWidget {
  const AllUtilityServiceScreen({Key? key}) : super(key: key);

  @override
  State<AllUtilityServiceScreen> createState() =>
      _AllUtilityServiceScreenState();
}

class _AllUtilityServiceScreenState extends State<AllUtilityServiceScreen> {
  Future<void> _loadData(BuildContext context, bool reload) async {
    if (reload) {
      Get.find<SplashController>().getConfigData();
    }

    Get.find<BillManageController>()
        .getUtilityServiceList(reload, isUpdate: reload);
  }

  @override
  void initState() {
    _loadData(context, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const CustomAppbar(title: 'Pay bill'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(
                  Dimensions.paddingSizeDefault,
                  Dimensions.paddingSizeDefault,
                  Dimensions.paddingSizeDefault,
                  0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimensions.radiusSizeSmall),
                      color: Theme.of(context).cardColor,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          // Adjust padding for the icon
                          child: SizedBox(
                            height: 22,
                            width: 22,
                            child: Image.asset(
                              Images.searchIcon,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            // controller: searchController,
                            keyboardType: TextInputType.name,
                            style: walsheimLight.copyWith(
                              fontSize: 15,
                              color: Theme.of(context).focusColor,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search utilities'.tr,
                              hintStyle: walsheimLight.copyWith(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  GetBuilder<SplashController>(builder: (splashController) {
                    return splashController
                            .configModel!.systemFeature!.linkedWebSiteStatus!
                        ? GetBuilder<BillManageController>(
                            builder: (billManageController) {
                            return billManageController.isLoading
                                ? const WebSiteShimmer()
                                : billManageController
                                        .utilityServiceList!.isEmpty
                                    ? const SizedBox()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 20, 0, 0),
                                            child: Text(
                                              "Pay your bills with SpeedPe",
                                              style: walsheimRegular.copyWith(
                                                fontSize: 16,
                                                color: Theme.of(context)
                                                    .focusColor
                                                    .withOpacity(0.9),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            width: double.infinity,
                                            margin: const EdgeInsets.only(
                                                top: Dimensions
                                                    .paddingSizeSmall),
                                            decoration: BoxDecoration(
                                              // color: Theme.of(context).colorScheme.background,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: ColorResources
                                                      .containerShedow
                                                      .withOpacity(0.05),
                                                  blurRadius: 20,
                                                  offset: const Offset(0, 3),
                                                )
                                              ],
                                            ),
                                            child: GridView.builder(
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4,
                                                childAspectRatio: 2 / 3.2,
                                              ),
                                              itemCount: billManageController
                                                  .utilityServiceList!.length,
                                              scrollDirection: Axis.vertical,
                                              itemBuilder: (context, index) {
                                                return CustomInkWell(
                                                  onTap: () => Get.to(WebScreen(
                                                      selectedUrl:
                                                          billManageController
                                                              .utilityServiceList![
                                                                  index]
                                                              .url!)),
                                                  radius: Dimensions
                                                      .radiusSizeExtraSmall,
                                                  highlightColor:
                                                      Theme.of(context)
                                                          .primaryColor
                                                          .withOpacity(0.1),
                                                  child: Container(
                                                    width: 90,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: Dimensions
                                                            .paddingSizeDefault),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          width: 55,
                                                          height: 55,
                                                          decoration: BoxDecoration(
                                                            color: Theme.of(context).cardColor,
                                                            borderRadius: BorderRadius.circular(15),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: ColorResources
                                                                    .containerShedow
                                                                    .withOpacity(0.05),
                                                                blurRadius: 20,
                                                                offset: const Offset(0, 3),
                                                              )
                                                            ],
                                                          ),
                                                          child: Container(
                                                            padding: const EdgeInsets.all(15),
                                                            height: 20,
                                                            width: 20,
                                                            child:
                                                                ExploreCustomImage(
                                                              image:
                                                                  "${Get.find<SplashController>().configModel!.baseUrls!.linkedWebsiteImageUrl}/${billManageController.utilityServiceList![index].image}",
                                                              placeholder: Images
                                                                  .webLinkPlaceHolder,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          billManageController
                                                              .utilityServiceList![
                                                                  index]
                                                              .name!.replaceAll(" ", "\n"),
                                                          textAlign:
                                                              TextAlign.center,
                                                          softWrap: true,
                                                          maxLines: 2,
                                                          style: walsheimMedium.copyWith(
                                                              fontSize: 12,
                                                              color: Theme.of(
                                                                      context)
                                                                  .indicatorColor
                                                                  .withOpacity(
                                                                      0.8)),
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
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
