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
import '../home/widget/shimmer/web_site_shimmer.dart';

class ViewAllServiceScreen extends StatefulWidget {
  const ViewAllServiceScreen({Key? key}) : super(key: key);

  @override
  State<ViewAllServiceScreen> createState() => _ViewAllServiceScreenState();
}

class _ViewAllServiceScreenState extends State<ViewAllServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const CustomAppbar(title: 'All Services'),
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
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimensions.radiusSizeSmall),
                      color: Theme.of(context).cardColor,
                      border: Border.all(
                        color:
                            Theme.of(context).highlightColor.withOpacity(0.5),
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
                            onTap: () => Get.toNamed(
                                RouteHelper.getSearchServiceRoute()),
                            child: TextField(
                              enabled: false,
                              //controller: searchController,
                              //onChanged: (inputText) => transactionMoneyController.searchContact(searchTerm: inputText.toLowerCase(),),
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
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeDefault),
                    child: Text(
                      'Recharge'.tr,
                      style: walsheimBold.copyWith(
                        fontSize: 15,
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                  ),
                  const CategoryContainer(filterText: "recharge"),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeDefault),
                    child: Text(
                      'Bill Payment'.tr,
                      style: walsheimBold.copyWith(
                        fontSize: 15,
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                  ),
                  const CategoryContainer(filterText: "bills"),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeDefault),
                    child: Text(
                      'Ticket Booking'.tr,
                      style: walsheimBold.copyWith(
                        fontSize: 15,
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                  ),
                  const CategoryContainer(filterText: "ticket"),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeDefault),
                    child: Text(
                      'Other'.tr,
                      style: walsheimBold.copyWith(
                        fontSize: 15,
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                  ),
                  const CategoryContainer(filterText: "other"),
                ],
              ),
            ),
            SizedBox(
              child: Image.asset(
                Images.monumentsIcon,
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CategoryContainer extends StatelessWidget {
  final String filterText;

  const CategoryContainer({Key? key, required this.filterText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WebsiteLinkController>(builder: (websiteLinkController) {
      List<WebsiteLinkModel> filteredList =
          websiteLinkController.getReversedFilteredWebsiteList(filterText);
      return websiteLinkController.isLoading
          ? const WebSiteShimmer()
          : websiteLinkController.websiteList!.isEmpty
              ? const SizedBox()
              : SizedBox(
                  height: 230, // Set a fixed height for the GridView
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
                );
    });
  }
}
