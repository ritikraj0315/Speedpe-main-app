import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/view/base/custom_app_bar.dart';
import 'package:six_cash/view/screens/social_media/chat/send_message.dart';
import '../../../../controller/splash_controller.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';
import '../../../base/custom_image.dart';
import '../controller/socialmedia_controller.dart';

class ProfileViewScreen extends StatefulWidget {
  final String uniqueId;

  const ProfileViewScreen({Key? key, required this.uniqueId}) : super(key: key);

  @override
  State<ProfileViewScreen> createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends State<ProfileViewScreen> {
  SocialMediaController socialMediaController =
      Get.find<SocialMediaController>();
  Map<String, dynamic>? buddyData;

  @override
  void initState() {
    super.initState();
    _fetchBuddyProfile();
  }

  Future<void> _fetchBuddyProfile() async {
    try {
      final response =
          await socialMediaController.getBuddyProfile(widget.uniqueId);

      if (response.statusCode == 200) {
        setState(() {
          buddyData = response.body;
        });
      } else {
        // Handle error
        print('Error fetching buddy profile data');
      }
    } catch (e) {
      // Handle exceptions
      print('Exception during buddy profile fetch: $e');
    }
  }

  void toggleFollowStatus(bool isFollowing, String userId) {
    if (isFollowing) {
      socialMediaController.unfollowUser(userId);
    } else {
      socialMediaController.followUser(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppbar(title: 'Profile'.tr),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width -
                          2 * Dimensions.paddingSizeLarge,
                      margin: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeLarge,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeLarge,
                        horizontal: Dimensions.paddingSizeLarge,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          Dimensions.radiusSizeDefault,
                        ),
                        color: Theme.of(context).cardColor,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context)
                                .highlightColor
                                .withOpacity(0.01),
                            blurRadius: 40,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          Text(
                            "${buddyData?['f_name'] ?? ''} ${buddyData?['l_name'] ?? ''}" !=
                                    ' '
                                ? "${buddyData?['f_name']} ${buddyData?['l_name']}"
                                : 'Not Available',
                            style: walsheimBold.copyWith(
                              color: Theme.of(context).focusColor,
                              fontSize: 17,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "@${buddyData?['username'] ?? 'not found'}",
                            style: walsheimMedium.copyWith(
                              color: Theme.of(context).focusColor,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  toggleFollowStatus(
                                      buddyData!['is_following'] == true,
                                      buddyData!['unique_id'].toString());
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      Dimensions.radiusSizeDefault,
                                    ),
                                    color: Theme.of(context).focusColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context)
                                            .highlightColor
                                            .withOpacity(0.01),
                                        blurRadius: 40,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                      child: Text(
                                    buddyData?['is_following'] == true
                                        ? "Following"
                                        : "Follow",
                                    style: walsheimMedium.copyWith(
                                      color: Theme.of(context).indicatorColor,
                                      fontSize: 16,
                                    ),
                                  )),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(SendMessageScreen(chatId: "",
                                      receiverId:
                                          buddyData!['unique_id'].toString(),
                                      fName: buddyData!['f_name'],
                                      lName: buddyData!['l_name']));
                                },
                                child: Container(
                                  height: 45.0,
                                  width: 45.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      Dimensions.radiusSizeDefault,
                                    ),
                                    color: Theme.of(context).focusColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context)
                                            .highlightColor
                                            .withOpacity(0.01),
                                        blurRadius: 40,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Image.asset(
                                        Images.messageTextIcon,
                                        color: Theme.of(context).indicatorColor,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "235",
                                      style: walsheimBold.copyWith(
                                        color: Theme.of(context).focusColor,
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Friends",
                                      style: walsheimMedium.copyWith(
                                        color: Theme.of(context).focusColor,
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "45",
                                      style: walsheimBold.copyWith(
                                        color: Theme.of(context).focusColor,
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Posts",
                                      style: walsheimMedium.copyWith(
                                        color: Theme.of(context).focusColor,
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "21",
                                      style: walsheimBold.copyWith(
                                        color: Theme.of(context).focusColor,
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Groups",
                                      style: walsheimMedium.copyWith(
                                        color: Theme.of(context).focusColor,
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(
                        width: 2,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        //Get.to(() => const ProfileViewScreen(id: ""));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: CustomImage(
                          image:
                              "${Get.find<SplashController>().configModel!.baseUrls!.customerImageUrl}/${buddyData?['image']}",
                          placeholder: Images.avatar,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 35,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Image.asset(
                  Images.horizontalLineIcon,
                  color: Theme.of(context).focusColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
