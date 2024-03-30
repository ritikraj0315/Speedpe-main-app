import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/view/screens/groups/select_members/model/select_member_model.dart';

import '../../../../controller/splash_controller.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_image.dart';
import '../../base/custom_ink_well.dart';
import '../social_media/profile_view/profile_view.dart';
import '../social_media/widget/shimmer/chat_list_shimmer.dart';
import 'controller/group_controller.dart';
import 'create_group_screen.dart';

class SelectMembersScreen extends StatefulWidget {
  final String type;

  const SelectMembersScreen({Key? key, required this.type}) : super(key: key);

  @override
  State<SelectMembersScreen> createState() => _SelectMembersScreenState();
}

class _SelectMembersScreenState extends State<SelectMembersScreen> {
  List<int> selectedUserIds = [];
  GroupController groupController = Get.find<GroupController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      groupController.getFollowingList(true);
    });
  }

  void navigateToScreenB() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateGroupScreen(
          selectedUserIds: selectedUserIds,
          type: widget.type,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GroupController>(builder: (groupController) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: const CustomAppbar(title: 'Select Members'),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildSearchField(context),
              const SizedBox(height: 25),
              buildSelectedUsersRow(),
              Expanded(
                child: _buildMembersList(context),
              ),
              ElevatedButton(
                onPressed: selectedUserIds.isNotEmpty
                    ? () {
                        navigateToScreenB();
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).indicatorColor, backgroundColor: Theme.of(context).primaryColor, padding: const EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 8,
                ),
                child: Container(
                  height: 55,
                  alignment: Alignment.center,
                  child: Text(
                    "Next",
                    style: walsheimMedium.copyWith(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildSearchField(BuildContext context) {
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
                  groupController.selectMemberList?.clear();
                  groupController.getFollowingList(true);
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

  Widget buildSelectedUsersRow() {
    return Wrap(
      spacing: 8.0,
      children: selectedUserIds.map((userId) {
        // Find the user with the specified userId
        SelectMemberModel? user;
        if (groupController.selectMemberList != null) {
          for (var member in groupController.selectMemberList!) {
            if (int.parse(member.uniqueId!) == userId) {
              user = member;
              break;
            }
          }
        }

        if (user != null) {
          return Chip(
            label: Text(user.fName!),
            deleteIcon: const Icon(Icons.cancel),
            onDeleted: () {
              setState(() {
                selectedUserIds.remove(userId);
              });
            },
          );
        } else {
          // Handle the case where no element is found (optional)
          return Container();
        }
      }).toList(),
    );
  }


  Widget _buildMembersList(BuildContext context) {
    return GetBuilder<GroupController>(builder: (groupController) {
      return groupController.isLoading
          ? const ChatListShimmer()
          : groupController.selectMemberList!.isEmpty
              ? const Center(child: Text("Chat list is empty"))
              : Expanded(
                  child: ListView.builder(
                    itemCount: groupController.selectMemberList!.length,
                    itemBuilder: (context, index) {
                      return CustomInkWell(
                        onTap: () {
                          Get.to(() => ProfileViewScreen(
                                uniqueId: groupController
                                        .selectMemberList![index].uniqueId ??
                                    'not found',
                              ));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                Dimensions.radiusSizeSmall),
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
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            width: 2,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            Get.to(() => ProfileViewScreen(
                                                  uniqueId: groupController
                                                          .selectMemberList![
                                                              index]
                                                          .uniqueId ??
                                                      'not found',
                                                ));
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CustomImage(
                                              image:
                                                  "${Get.find<SplashController>().configModel!.baseUrls!.customerImageUrl}/${groupController.selectMemberList![index].image}",
                                              placeholder:
                                                  Images.webLinkPlaceHolder,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${groupController.selectMemberList![index].fName!} ${groupController.selectMemberList![index].lName!}",
                                            textAlign: TextAlign.center,
                                            style: walsheimBold.copyWith(
                                              fontSize: 15,
                                              color:
                                                  Theme.of(context).focusColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "@${groupController.selectMemberList![index].username ?? 'not found'}",
                                            textAlign: TextAlign.center,
                                            style: walsheimMedium.copyWith(
                                              fontSize: 11,
                                              color:
                                                  Theme.of(context).focusColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Checkbox(
                                    value: selectedUserIds.contains(int.parse(
                                        groupController.selectMemberList![index]
                                            .uniqueId!)),
                                    onChanged: (value) {
                                      setState(() {
                                        if (value!) {
                                          selectedUserIds.add(int.parse(
                                              groupController
                                                  .selectMemberList![index]
                                                  .uniqueId!));
                                        } else {
                                          selectedUserIds.remove(int.parse(
                                              groupController
                                                  .selectMemberList![index]
                                                  .uniqueId!));
                                        }
                                      });
                                    },
                                  ),
                                ],
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
