import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/view/screens/bill_manage/widget/service_custom_image.dart';
import '../../../controller/splash_controller.dart';
import '../../../controller/websitelink_controller.dart';
import '../../../data/model/websitelink_models.dart';
import '../../../helper/app_routes.dart';
import '../../../helper/route_helper.dart';
import '../../../util/color_resources.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/styles.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_ink_well.dart';

class SearchServiceScreen extends StatefulWidget {
  const SearchServiceScreen({Key? key}) : super(key: key);

  @override
  State<SearchServiceScreen> createState() => _SearchServiceScreenState();
}

class _SearchServiceScreenState extends State<SearchServiceScreen> {
  List<WebsiteLinkModel> filteredList = [];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WebsiteLinkController>(builder: (websiteLinkController) {
      return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: const CustomAppbar(title: 'Search'),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.radiusSizeSmall),
                    color: Theme.of(context).cardColor,
                    border: Border.all(
                      color: Theme.of(context).highlightColor.withOpacity(0.5),
                      width: 0.8,
                      style: BorderStyle.solid,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeDefault),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () =>
                              Get.toNamed(RouteHelper.getSearchServiceRoute()),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                // Update the filteredList based on the search query
                                filteredList = websiteLinkController
                                    .getSearchWebsiteList(value);
                              });
                            },
                            keyboardType: TextInputType.name,
                            style: walsheimMedium.copyWith(
                              fontSize: Dimensions.fontSizeDefault,
                              color: ColorResources.whiteColor,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search service'.tr,
                              hintStyle: walsheimMedium.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                                color: ColorResources.getGreyBaseGray1(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Icon(Icons.search, color: Theme.of(context).cardColor),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 1200, // Set a fixed height for the GridView
                  child: GridView.builder(
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
                            color: Theme.of(context).cardColor,
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
                                    placeholder: Images.webLinkPlaceHolder,
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
                                style: walsheimMedium.copyWith(
                                    fontSize: 11,
                                    color: Theme.of(context).focusColor),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ));
    });
  }
}
