import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/screens/social_media/search_buddy/search_buddy.dart';
import 'package:six_cash/view/screens/social_media/widget/shimmer/chat_list_shimmer.dart';
import '../../../../util/images.dart';
import '../../../controller/splash_controller.dart';
import '../../base/custom_image.dart';
import '../../base/custom_ink_well.dart';
import '../home/widget/app_bar_base.dart';
import 'chat/send_message.dart';
import 'controller/socialmedia_controller.dart';

class SpeedXHomeScreen extends StatefulWidget {
  final String? phoneNumber;

  const SpeedXHomeScreen({Key? key, this.phoneNumber}) : super(key: key);

  @override
  State<SpeedXHomeScreen> createState() => _SpeedXHomeScreenState();
}

class _SpeedXHomeScreenState extends State<SpeedXHomeScreen> {
  SocialMediaController socialMediaController =
      Get.find<SocialMediaController>();
  ProfileController profileController = Get.find<ProfileController>();

  @override
  void initState() {
    socialMediaController.getChatList(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const AppBarBase(),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.to(const SearchBuddyScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Theme.of(context).indicatorColor, backgroundColor: Theme.of(context).primaryColor, padding: const EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 8,
                  ),
                  child: Container(
                    height: 50,
                    width: (MediaQuery.of(context).size.width + 92) / 2,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            Images.addMoneyIcon,
                            color: Theme.of(context).indicatorColor,
                          ),
                        ),
                        Text(
                          "New chat",
                          style: walsheimMedium.copyWith(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 50,
                  height: 50,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).primaryColor,
                    border: Border.all(
                      width: 0,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      showMenuBottomSheet(context, "username");
                    },
                    child: ClipRRect(
                      child: Image.asset(
                        Images.menuDotIcon,
                        color: Theme.of(context).indicatorColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              'Chats'.tr,
              textAlign: TextAlign.start,
              style: walsheimBold.copyWith(
                color: Theme.of(context).focusColor,
                fontSize: 20,
              ),
            ),
            //_chatsList(context),
            const ChatListContainer(),
          ],
        ),
      ),),
    );
  }
}

class ChatListContainer extends StatelessWidget {
  const ChatListContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.find<ProfileController>();
    return GetBuilder<SocialMediaController>(builder: (socialMediaController) {
      return socialMediaController.isLoading
          ? const ChatListShimmer()
          : socialMediaController.chatList!.isEmpty
              ? const Center(child: Text("Chat list is empty"))
              : Expanded(
                  //height: 230,
                  child: ListView.builder(
                    itemCount: socialMediaController.chatList!.length,
                    itemBuilder: (context, index) {
                      return CustomInkWell(
                        onTap: () {
                          if (socialMediaController.chatList![index].user2Id!
                              .toString()
                              .endsWith(profileController.userInfo!.uniqueId
                                  .toString())) {
                            Get.to(SendMessageScreen(
                                chatId: socialMediaController
                                    .chatList![index].id!
                                    .toString(),
                                receiverId: socialMediaController
                                    .chatList![index].user1Id!
                                    .toString(),
                                fName: socialMediaController
                                    .chatList![index].firstName!,
                                lName: socialMediaController
                                    .chatList![index].lastName!));
                          } else {
                            Get.to(SendMessageScreen(
                                chatId: socialMediaController
                                    .chatList![index].id!
                                    .toString(),
                                receiverId: socialMediaController
                                    .chatList![index].user2Id!
                                    .toString(),
                                fName: socialMediaController.chatList![index].firstName!,
                                lName: socialMediaController
                                    .chatList![index].lastName!));
                          }
                        },
                        child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radiusSizeSmall),
                              //color: Theme.of(context).cardColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context)
                                      .cardColor
                                      .withOpacity(0.01),
                                  blurRadius: 40,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 0,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(SendMessageScreen(
                                          chatId: socialMediaController
                                              .chatList![index].id!
                                              .toString(),
                                          receiverId: socialMediaController
                                              .chatList![index].user2Id!
                                              .toString(),
                                          fName: socialMediaController
                                              .chatList![index].firstName!,
                                          lName: socialMediaController
                                              .chatList![index].lastName!));
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CustomImage(
                                        image:
                                            "${Get.find<SplashController>().configModel!.baseUrls!.customerImageUrl}/${socialMediaController.chatList![index].image}",
                                        placeholder: Images.avatar,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 92,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${socialMediaController.chatList![index].firstName! ?? ''} ${socialMediaController.chatList![index].lastName! ?? ''}" !=
                                                ' '
                                            ? "${socialMediaController.chatList![index].firstName!} ${socialMediaController.chatList![index].lastName!}"
                                            : 'Not Available',
                                        textAlign: TextAlign.start,
                                        style: walsheimBold.copyWith(
                                          fontSize: 15,
                                          color: Theme.of(context).focusColor,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "message: ${socialMediaController.chatList![index].lastMessage ?? 'Not found'}",
                                        textAlign: TextAlign.start,
                                        maxLines: 1,
                                        style: walsheimMedium.copyWith(
                                          fontSize: 11,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      );
                    },
                  ),
                );
    });
  }
}

void showMenuBottomSheet(context, String username) {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(Dimensions.radiusSizeLarge)),
      ),
      backgroundColor: Theme.of(context).cardColor,
      builder: (BuildContext bc) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Wrap(
            spacing: 60,
            children: <Widget>[
              Column(
                children: [
                  Container(
                    height: 35,
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.symmetric(vertical: 0),
                    child: Center(
                      child: Image.asset(
                        Images.horizontalLineIcon,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(const SendMessageScreen(
                          chatId: "",
                          receiverId: "13878100",
                          fName: "SpeedX",
                          lName: "Ai"));
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: Image.asset(
                            Images.robotIcon,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Message Ai",
                          textAlign: TextAlign.start,
                          style: walsheimMedium.copyWith(
                            color: Theme.of(context).focusColor,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(height: 10),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 30,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.transparent,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Close",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      });
}
