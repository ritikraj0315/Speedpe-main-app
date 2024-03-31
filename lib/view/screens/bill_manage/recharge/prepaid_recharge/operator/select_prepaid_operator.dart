import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../controller/splash_controller.dart';
import '../../../../../../helper/app_routes.dart';
import '../../../../../../util/color_resources.dart';
import '../../../../../../util/dimensions.dart';
import '../../../../../../util/images.dart';
import '../../../../../../util/styles.dart';
import '../../../../../base/custom_app_bar.dart';
import '../../../../../base/custom_ink_well.dart';
import '../../../../../base/explore_custom_image.dart';
import '../../../../home/widget/shimmer/web_site_shimmer.dart';
import '../../../controller/billmanage_controller.dart';

class SelectPrepaidOperatorScreen extends StatefulWidget {
  const SelectPrepaidOperatorScreen({Key? key, required this.number})
      : super(key: key);
  final String number;

  @override
  State<SelectPrepaidOperatorScreen> createState() =>
      _SelectPrepaidOperatorScreenState();
}

class _SelectPrepaidOperatorScreenState
    extends State<SelectPrepaidOperatorScreen> {
  Future<void> _loadData(BuildContext context, bool reload) async {
    if (reload) {
      Get.find<SplashController>().getConfigData();
    }

    Get.find<BillManageController>()
        .getUtilityOperatorList(reload, isUpdate: reload);
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
      appBar: const CustomAppbar(title: 'Select Operator'),
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
                              hintText: 'Search operator'.tr,
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
                                        .utilityOperatorList!.isEmpty
                                    ? const SizedBox()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            width: double.infinity,
                                            child: ListView.builder(
                                              itemCount: billManageController
                                                  .utilityOperatorList!.length,
                                              scrollDirection: Axis.vertical,
                                              itemBuilder: (context, index) {
                                                return CustomInkWell(
                                                  onTap: () => AppRoutes.openScreen(
                                                      billManageController
                                                          .utilityOperatorList![
                                                              index]
                                                          .infoText!),
                                                  radius: Dimensions
                                                      .radiusSizeExtraSmall,
                                                  highlightColor:
                                                      Theme.of(context)
                                                          .primaryColor
                                                          .withOpacity(0.1),
                                                  child: Container(
                                                    width: 90,
                                                    margin: const EdgeInsets
                                                        .symmetric(vertical: 8),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .cardColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 45,
                                                          height: 45,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Theme.of(
                                                                    context)
                                                                .cardColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            // Half of width/height to make it a circle
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: ColorResources
                                                                    .containerShedow
                                                                    .withOpacity(
                                                                        0.05),
                                                                blurRadius: 20,
                                                                offset:
                                                                    const Offset(
                                                                        0, 3),
                                                              ),
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            // Half of width/height to clip content as circle
                                                            child:
                                                                Image.network(
                                                              "${Get.find<SplashController>().configModel!.baseUrls!.linkedWebsiteImageUrl}/${billManageController.utilityOperatorList![index].image}" ??
                                                                  Images
                                                                      .loadingIcon,
                                                              fit: BoxFit
                                                                  .cover, // Adjust the fit as needed
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 15,
                                                        ),
                                                        Text(
                                                          billManageController
                                                              .utilityOperatorList![
                                                                  index]
                                                              .title!,
                                                          textAlign:
                                                              TextAlign.center,
                                                          softWrap: true,
                                                          maxLines: 2,
                                                          style: walsheimBold.copyWith(
                                                              fontSize: 14,
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
