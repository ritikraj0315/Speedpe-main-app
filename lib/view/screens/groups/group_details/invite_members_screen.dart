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
import '../../../base/custom_snackbar.dart';
import '../../social_media/profile_view/profile_view.dart';
import '../../social_media/widget/shimmer/chat_list_shimmer.dart';
import '../controller/group_controller.dart';
import 'model/invite_member_model.dart';

class InviteMembersScreen extends StatefulWidget {
  final String groupId;

  const InviteMembersScreen({Key? key, required this.groupId})
      : super(key: key);

  @override
  State<InviteMembersScreen> createState() => _InviteMembersScreenState();
}

class _InviteMembersScreenState extends State<InviteMembersScreen> {
  List<int> selectedInviteIds = [];
  GroupController groupController = Get.find<GroupController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      groupController.getInviteMemberList(true, widget.groupId);
    });
  }

  void addMembers() {
     if (selectedInviteIds.isEmpty) {
      showCustomSnackBar('Please select a member'.tr, isError: true);
    } else {
      Get.find<GroupController>()
          .addMemberToGroup(selectedInviteIds, widget.groupId)
          .then((value) {
        if (value.statusCode == 200) {
          Navigator.pop(context);
        }
      });
    }

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => CreateGroupScreen(
    //       selectedUserIds: selectedUserIds,
    //       type: widget.type,
    //     ),
    //   ),
    // );
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
                onPressed: selectedInviteIds.isNotEmpty
                    ? () {
                  addMembers();
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
                    "Add/Invite",
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
                  groupController.inviteMemberList?.clear();
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
      children: selectedInviteIds.map((userId) {
        // Find the user with the specified userId
        InviteMemberModel? user;
        if (groupController.inviteMemberList != null) {
          for (var member in groupController.inviteMemberList!) {
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
                selectedInviteIds.remove(userId);
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
          : groupController.inviteMemberList!.isEmpty
              ? const Center(child: Text("list is empty"))
              : Expanded(
                  child: ListView.builder(
                    itemCount: groupController.inviteMemberList!.length,
                    itemBuilder: (context, index) {
                      return CustomInkWell(
                        onTap: () {},
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
                                                          .inviteMemberList![
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
                                                  "${Get.find<SplashController>().configModel!.baseUrls!.customerImageUrl}/${groupController.inviteMemberList![index].image}",
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
                                          Row(
                                            children: [
                                              Text(
                                                "${groupController.inviteMemberList![index].fName!} ${groupController.inviteMemberList![index].lName!}",
                                                textAlign: TextAlign.center,
                                                style: walsheimBold.copyWith(
                                                  fontSize: 15,
                                                  color: Theme.of(context)
                                                      .focusColor,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              if (groupController
                                                      .inviteMemberList![index]
                                                      .isExists! ==
                                                  1)
                                                GestureDetector(
                                                  onTap: () {
                                                    showMenuInfo(context);
                                                  },
                                                  child: SizedBox(
                                                    height: 20,
                                                    width: 20,
                                                    child: Image.asset(
                                                      Images.infoIcon,
                                                      color: Theme.of(context)
                                                          .focusColor,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "@${groupController.inviteMemberList![index].username ?? 'not found'}",
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
                                  if (groupController
                                          .inviteMemberList![index].isExists! ==
                                      0)
                                    Checkbox(
                                      value: selectedInviteIds.contains(
                                          int.parse(groupController
                                              .inviteMemberList![index]
                                              .uniqueId!)),
                                      onChanged: (value) {
                                        setState(() {
                                          if (value!) {
                                            selectedInviteIds.add(int.parse(
                                                groupController
                                                    .inviteMemberList![index]
                                                    .uniqueId!));
                                          } else {
                                            selectedInviteIds.remove(int.parse(
                                                groupController
                                                    .inviteMemberList![index]
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

void showMenuInfo(context) {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(Dimensions.radiusSizeLarge)),
      ),
      backgroundColor: Theme.of(context).cardColor,
      builder: (BuildContext bc) {
        GroupController groupController = Get.find<GroupController>();
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
                      Navigator.pop(context);
                      // Get.to(ProfileViewScreen(
                      //   uniqueId: userId,
                      // ));
                    },
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          height: 30,
                          width: 30,
                          child: Image.asset(
                            Images.infoIcon,
                            color:
                                Theme.of(context).focusColor.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Member already exists!",
                          textAlign: TextAlign.start,
                          style: walsheimRegular.copyWith(
                            color: Theme.of(context).focusColor,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(height: 20),
                ],
              ),
            ],
          ),
        );
      });
}
