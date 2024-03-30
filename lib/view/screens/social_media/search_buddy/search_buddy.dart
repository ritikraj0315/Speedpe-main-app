import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/splash_controller.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';
import '../../../base/custom_app_bar.dart';
import '../../../base/custom_image.dart';
import '../../../base/custom_ink_well.dart';
import '../controller/socialmedia_controller.dart';
import '../profile_view/profile_view.dart';
import 'model/search_buddy_model.dart';

class SearchBuddyScreen extends StatefulWidget {
  const SearchBuddyScreen({Key? key}) : super(key: key);

  @override
  State<SearchBuddyScreen> createState() => _SearchBuddyScreenState();
}

class _SearchBuddyScreenState extends State<SearchBuddyScreen> {
  SocialMediaController socialMediaController =
      Get.find<SocialMediaController>();
  List<SearchBuddyModel> _buddyList = [];

  @override
  void initState() {
    socialMediaController.getSearchBuddyList("ai").then((value) {
      _buddyList = [];
      if (value.statusCode == 200) {
        _buddyList = [];
        value.body.forEach((buddy) {
          _buddyList.add(SearchBuddyModel.fromJson(buddy));
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialMediaController>(builder: (socialMediaController) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: const CustomAppbar(title: 'Search buddy'),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildSearchField(context, socialMediaController),
              const SizedBox(height: 25),
              Expanded(
                child: _buildBuddyList(context),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildSearchField(
      BuildContext context, SocialMediaController socialMediaController) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
        color: Theme.of(context).cardColor,
        border: Border.all(
          color: Theme.of(context).highlightColor.withOpacity(0.5),
          width: 0.8,
          style: BorderStyle.solid,
        ),
      ),
      padding:
          const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _buddyList.clear();
                  socialMediaController.getSearchBuddyList(value).then((value) {
                    value.body.forEach((buddy) {
                      _buddyList.add(SearchBuddyModel.fromJson(buddy));
                    });
                  });
                });
              },
              keyboardType: TextInputType.name,
              style: walsheimMedium.copyWith(
                fontSize: Dimensions.fontSizeDefault,
                color: ColorResources.whiteColor,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Type name or username'.tr,
                hintStyle: walsheimMedium.copyWith(
                  fontSize: Dimensions.fontSizeDefault,
                  color: ColorResources.getGreyBaseGray1(),
                ),
              ),
            ),
          ),
          Icon(Icons.search, color: Theme.of(context).cardColor),
        ],
      ),
    );
  }

  Widget _buildBuddyList(BuildContext context) {
    return ListView.builder(
      itemCount: _buddyList.length,
      itemBuilder: (context, index) {
        return CustomInkWell(
          onTap: () {
            //showCustomSnackBar(_buddyList[index].uniqueId);
            Get.to(() => ProfileViewScreen(
                  uniqueId: _buddyList[index].uniqueId ?? 'not found',
                ));
          },
          child: Container(
              //padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
                //color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).cardColor.withOpacity(0.01),
                    blurRadius: 40,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 2,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => ProfileViewScreen(
                                  uniqueId:
                                      _buddyList[index].uniqueId ?? 'not found',
                                ));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CustomImage(
                              image: "${Get.find<SplashController>().configModel!.baseUrls!.customerImageUrl}/${_buddyList[index].image}",
                              placeholder: Images.webLinkPlaceHolder,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${_buddyList[index].fName!} ${_buddyList[index].lName!}",
                            textAlign: TextAlign.center,
                            style: walsheimBold.copyWith(
                              fontSize: 15,
                              color: Theme.of(context).focusColor,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "@${_buddyList[index].username ?? 'not found'}",
                            textAlign: TextAlign.center,
                            style: walsheimMedium.copyWith(
                              fontSize: 11,
                              color: Theme.of(context).focusColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )),
        );
      },
    );
  }
}
