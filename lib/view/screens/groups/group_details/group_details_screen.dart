import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/view/base/custom_app_bar.dart';
import 'package:six_cash/view/screens/groups/controller/group_controller.dart';
import 'package:six_cash/view/screens/groups/group_details/invite_members_screen.dart';
import 'package:six_cash/view/screens/social_media/profile_view/profile_view.dart';
import '../../../../controller/splash_controller.dart';
import '../../../../helper/route_helper.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';
import '../../../base/custom_image.dart';
import '../../../base/custom_ink_well.dart';
import '../joined_group/model/joined_group_model.dart';
import '../widget/shimmer/member_list_shimmer.dart';

class GroupDetailsScreen extends StatefulWidget {
  final String groupId;
  final String memberType;
  final JoinedGroupModel model;

  const GroupDetailsScreen({
    Key? key,
    required this.groupId,
    required this.model,
    required this.memberType,
  }) : super(key: key);

  @override
  State<GroupDetailsScreen> createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
  GroupController groupController = Get.find<GroupController>();
  bool isMsgAllow = true;

  @override
  void initState() {
    super.initState();
    groupController.getGroupDetails(widget.groupId).then((value) {
      if (value.statusCode == 200) {
        if (value.body['is_group_open'] == 2) {
          setState(() {
            isMsgAllow = false;
          });
        }
      }
    });
    groupController.getGroupMembers(widget.groupId);
  }

  @override
  Widget build(BuildContext context) {
    DateTime originalDateTime =
        DateTime.parse(widget.model.createdAt ?? '2024-01-06 19:15:53');
    String formattedDate = DateFormat("dd MMM yyyy").format(originalDateTime);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const CustomAppbar(title: ''),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 90,
                  height: 90,
                  padding: const EdgeInsets.all(3),
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
                      // showMenuBottomSheet();
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: CustomImage(
                        image:
                            "${Get.find<SplashController>().configModel!.baseUrls!.customerImageUrl}/${widget.model.groupName}",
                        placeholder: Images.avatar,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.model.groupName ?? 'not found',
                          style: walsheimBold.copyWith(
                            color: Theme.of(context).focusColor,
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Created on ${formattedDate ?? 'not found'}",
                          style: walsheimMedium.copyWith(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.5),
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
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
                      color: Theme.of(context).highlightColor.withOpacity(0.01),
                      blurRadius: 40,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    if (widget.memberType == "2")
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() =>
                                  InviteMembersScreen(groupId: widget.groupId));
                            },
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  height: 30,
                                  width: 30,
                                  child: Image.asset(
                                    Images.addSquareIcon,
                                    color: Theme.of(context).focusColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Add members",
                                      textAlign: TextAlign.start,
                                      style: walsheimMedium.copyWith(
                                        color: Theme.of(context).focusColor,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      "Invite or add members in the group.",
                                      textAlign: TextAlign.start,
                                      style: walsheimRegular.copyWith(
                                        color: Theme.of(context)
                                            .focusColor
                                            .withOpacity(0.5),
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                            child: const Divider(
                              height: 25,
                            ),
                          ),
                        ],
                      ),
                    if (widget.memberType == "2")
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(2),
                                    height: 30,
                                    width: 30,
                                    child: Image.asset(
                                      Images.sendMsgIcon,
                                      color: Theme.of(context).focusColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Send message",
                                        textAlign: TextAlign.start,
                                        style: walsheimMedium.copyWith(
                                          color: Theme.of(context).focusColor,
                                          fontSize: 13,
                                        ),
                                      ),
                                      Text(
                                        "choose weather member\ncan send message",
                                        textAlign: TextAlign.start,
                                        style: walsheimRegular.copyWith(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.5),
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Switch(
                                value: isMsgAllow,
                                onChanged: (value) {
                                  setState(() {
                                    isMsgAllow = value;
                                    groupController
                                        .changeGroupOpenStatus(widget.groupId);
                                  });
                                },
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                            child: const Divider(
                              height: 25,
                            ),
                          ),
                        ],
                      ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            _showExitConfirmationDialog(context);
                          },
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(2),
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                  Images.logoutIcon,
                                  color: ColorResources.lightRedColor,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Exit group",
                                    textAlign: TextAlign.start,
                                    style: walsheimMedium.copyWith(
                                      color: ColorResources.lightRedColor,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    "Remove yourself and delete group",
                                    textAlign: TextAlign.start,
                                    style: walsheimRegular.copyWith(
                                      color: ColorResources.lightRedColor
                                          .withOpacity(0.5),
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (widget.memberType == "2")
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                            child: const Divider(
                              height: 25,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _showDeleteConfirmationDialog(context);
                            },
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  height: 30,
                                  width: 30,
                                  child: Image.asset(
                                    Images.deleteIcon,
                                    color: ColorResources.lightRedColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Delete group",
                                      textAlign: TextAlign.start,
                                      style: walsheimMedium.copyWith(
                                        color: ColorResources.lightRedColor,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      "Remove all members and delete group",
                                      textAlign: TextAlign.start,
                                      style: walsheimRegular.copyWith(
                                        color: ColorResources.lightRedColor
                                            .withOpacity(0.5),
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
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
              _buildMemberList(context),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showExitConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          title: Text(
            'Are you sure you want to exit and delete the group?',
            textAlign: TextAlign.start,
            style: walsheimRegular.copyWith(
              color: Theme.of(context).focusColor,
              fontSize: 15,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                textAlign: TextAlign.start,
                style: walsheimRegular.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: 15,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                groupController.exitGroup(widget.groupId).then((value) {
                  if (value.statusCode == 200) {
                    Navigator.popUntil(
                        context, ModalRoute.withName(RouteHelper.navbar));
                  }
                });
              },
              child: Text(
                'OK',
                textAlign: TextAlign.start,
                style: walsheimRegular.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: 15,
                ),
              ),
            ),
            // Cancel button
          ],
        );
      },
    );
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          title: Text(
            'Are you sure you want to delete the group?',
            textAlign: TextAlign.start,
            style: walsheimRegular.copyWith(
              color: Theme.of(context).focusColor,
              fontSize: 15,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                textAlign: TextAlign.start,
                style: walsheimRegular.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: 15,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                groupController.deleteGroup(widget.groupId).then((value) {
                  if (value.statusCode == 200) {
                    Navigator.popUntil(
                        context, ModalRoute.withName(RouteHelper.navbar));
                  }
                });
              },
              child: Text(
                'OK',
                textAlign: TextAlign.start,
                style: walsheimRegular.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: 15,
                ),
              ),
            ),
            // Cancel button
          ],
        );
      },
    );
  }

  Widget _buildMemberList(BuildContext context) {
    return GetBuilder<GroupController>(builder: (groupController) {
      return groupController.isLoading
          ? const MemberListShimmer()
          : groupController.groupMemberModel!.isEmpty
              ? const Center(child: Text("Members not found!"))
              : Expanded(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: groupController.groupMemberModel!.length,
                    itemBuilder: (context, index) {
                      DateTime originalDateTime = DateTime.parse(
                          groupController.groupMemberModel![index].joinedAt!);
                      String formattedDate =
                          DateFormat("dd MMM yyyy").format(originalDateTime);
                      return CustomInkWell(
                        onTap: () {
                          showMenuBottomSheet(
                              context,
                              groupController.groupMemberModel![index].userId!
                                  .toString(),
                              widget.model.id.toString(),
                              groupController.groupMemberModel![index].id!
                                  .toString(),
                              groupController
                                  .groupMemberModel![index].memberType!
                                  .toString(),
                              widget.memberType);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: Dimensions.paddingSizeDefault),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                Dimensions.radiusSizeSmall),
                            // color: Theme.of(context).cardColor,
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
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 45,
                                          height: 45,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            border: Border.all(
                                              width: 1.5,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              // Get.to(() => ProfileViewScreen(
                                              //       uniqueId: joinedGroupModel[index].id ??
                                              //           'not found',
                                              //     ));
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              child: CustomImage(
                                                image:
                                                    "${Get.find<SplashController>().configModel!.baseUrls!.customerImageUrl}/${groupController.groupMemberModel![index].memberImage}",
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
                                              groupController
                                                      .groupMemberModel![index]
                                                      .memberFirstName ??
                                                  'not found',
                                              textAlign: TextAlign.center,
                                              style: walsheimBold.copyWith(
                                                fontSize: 15,
                                                color: Theme.of(context)
                                                    .focusColor,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              "Joined on $formattedDate",
                                              textAlign: TextAlign.center,
                                              style: walsheimMedium.copyWith(
                                                fontSize: 11,
                                                color: Theme.of(context)
                                                    .focusColor
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    if (groupController.groupMemberModel![index]
                                            .memberType ==
                                        2)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Theme.of(context).primaryColor,
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
                                        child: Text(
                                          "Admin",
                                          textAlign: TextAlign.center,
                                          style: walsheimMedium.copyWith(
                                            fontSize: 10,
                                            color: Theme.of(context)
                                                .indicatorColor,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
    });
  }
}

void showMenuBottomSheet(context, String userId, String groupId,
    String memberId, String memberType, String currentMemberType) {
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
                      Get.to(ProfileViewScreen(
                        uniqueId: userId,
                      ));
                    },
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          height: 30,
                          width: 30,
                          child: Image.asset(
                            Images.profileIcon,
                            color:
                                Theme.of(context).focusColor.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "View profile",
                          textAlign: TextAlign.start,
                          style: walsheimRegular.copyWith(
                            color: Theme.of(context).focusColor,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (currentMemberType == "2")
                    Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            groupController
                                .promoteGroupAdmin(memberId, groupId)
                                .then((value) {
                              if (value.statusCode == 200) {
                                groupController.getGroupMembers(groupId);
                              }
                            });
                          },
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                  Images.crownIcon,
                                  color: (memberType != '2')
                                      ? Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.7)
                                      : ColorResources.lightRedColor,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                (memberType != '2')
                                    ? "Promote as Admin"
                                    : "Demote as Member",
                                textAlign: TextAlign.start,
                                style: walsheimRegular.copyWith(
                                  color: (memberType != '2')
                                      ? Theme.of(context).focusColor
                                      : ColorResources.lightRedColor,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  if (currentMemberType == "2")
                    Visibility(
                        visible: true,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                groupController
                                    .removeMember(memberId, groupId)
                                    .then((value) {
                                  if (value.statusCode == 200) {
                                    groupController.getGroupMembers(groupId);
                                  }
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    height: 30,
                                    width: 30,
                                    child: Image.asset(
                                      Images.deleteIcon,
                                      color: ColorResources.lightRedColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Remove member",
                                    textAlign: TextAlign.start,
                                    style: walsheimRegular.copyWith(
                                      color: ColorResources.lightRedColor,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  Container(height: 20),
                ],
              ),
            ],
          ),
        );
      });
}
