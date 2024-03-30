import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../controller/splash_controller.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';
import '../../../base/custom_app_bar.dart';
import '../../../base/custom_image.dart';
import '../controller/group_controller.dart';
import '../group_chat/send_group_message_screen.dart';
import '../widget/shimmer/group_list_shimmer.dart';
import 'model/joined_group_model.dart';

class JoinedGroupScreen extends StatefulWidget {
  const JoinedGroupScreen({Key? key}) : super(key: key);

  @override
  State<JoinedGroupScreen> createState() => _JoinedGroupScreenState();
}

class _JoinedGroupScreenState extends State<JoinedGroupScreen> {
  final TextEditingController _searchTextFieldController =
      TextEditingController();
  GroupController groupController = Get.find<GroupController>();

  @override
  void initState() {
    super.initState();
  }

  void _onSearchTextChanged(String value) {
    setState(() {
      //joinedGroupModel = groupController.filterJoinedGroups(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GroupController>(builder: (groupController) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: const CustomAppbar(title: 'Your groups'),
        body: Padding(
          padding: const EdgeInsets.all(16),
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
                      child: SizedBox(
                        height: 22,
                        width: 22,
                        child: Image.asset(
                          Images.searchIcon,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _searchTextFieldController,
                        onChanged: _onSearchTextChanged,
                        keyboardType: TextInputType.name,
                        style: walsheimRegular.copyWith(
                          fontSize: 15,
                          color: Theme.of(context).focusColor,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Type group name'.tr,
                          hintStyle: walsheimRegular.copyWith(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Text(
                'Split Payments Groups',
                textAlign: TextAlign.start,
                style: walsheimRegular.copyWith(
                  fontSize: 16,
                  color: Theme.of(context).focusColor.withOpacity(0.8),
                ),
              ),
              Expanded(
                child: _buildPaymentGroupList(context),
              ),
              //const SizedBox(height: 25),
              Text(
                'Groups',
                textAlign: TextAlign.start,
                style: walsheimRegular.copyWith(
                  fontSize: 16,
                  color: Theme.of(context).focusColor.withOpacity(0.8),
                ),
              ),
              Expanded(
                child: _buildGroupList(context),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildPaymentGroupList(BuildContext context) {
    return GetBuilder<GroupController>(
      builder: (groupController) {
        List<JoinedGroupModel> groupPaymentList = groupController.getPaymentsGroupsList('3');
        return groupController.isLoading
            ? const GroupListShimmer()
            : groupPaymentList.isEmpty
                ? const Center(child: Text("No group found!"))
                : Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: groupPaymentList.length,
                      itemBuilder: (context, index) {
                        DateTime originalDateTime = DateTime.parse(
                            groupPaymentList[index].createdAt!);
                        String formattedDate =
                            DateFormat("dd MMM yyyy").format(originalDateTime);
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => SendGroupMessageScreen(
                                  groupId: groupPaymentList[index].id!
                                      .toString(),
                                  groupName: groupPaymentList[index].groupName!,
                                  creatorId: groupPaymentList[index].createdBy!
                                      .toString(),
                                  model: groupPaymentList[index],
                                ));
                          },
                          child: Row(
                            children: [
                              Container(
                                width: 180,
                                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                                margin: const EdgeInsets.symmetric(vertical: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radiusSizeDefault),
                                  color: Theme.of(context).cardColor,
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(30),
                                            child: CustomImage(
                                              image:
                                              "${Get.find<SplashController>().configModel!.baseUrls!.customerImageUrl}/${groupPaymentList[index].groupTag!}",
                                              placeholder:
                                              Images.webLinkPlaceHolder,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5,),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                groupPaymentList[index]
                                                    .groupName!,
                                                textAlign: TextAlign.center,
                                                style: walsheimBold.copyWith(
                                                  fontSize: 14,
                                                  color: Theme.of(context)
                                                      .focusColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Requested Amount',
                                                textAlign: TextAlign.center,
                                                style: walsheimRegular.copyWith(
                                                  fontSize: 14,
                                                  color: Theme.of(context)
                                                      .focusColor.withOpacity(0.8),
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                '₹ 150',
                                                textAlign: TextAlign.center,
                                                style: walsheimMedium.copyWith(
                                                  fontSize: 18,
                                                  color: Theme.of(context)
                                                      .focusColor
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Created on $formattedDate",
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
                                  ],
                                ),
                              ),
                              const SizedBox(width: 15,)
                            ],
                          )
                        );
                      },
                    ),
                  );
      },
    );
  }

  Widget _buildGroupList(BuildContext context) {
    return GetBuilder<GroupController>(builder: (groupController) {
      List<JoinedGroupModel> groupList = groupController.getPaymentsGroupsList('2');
      return groupController.isLoading
          ? const GroupListShimmer()
          : groupList.isEmpty
              ? const Center(child: Text("No group found!"))
              : Expanded(
                  //height: 230,
                  child: ListView.builder(
                    itemCount: groupList.length,
                    itemBuilder: (context, index) {
                      DateTime originalDateTime = DateTime.parse(
                          groupList[index].createdAt!);
                      String formattedDate =
                          DateFormat("dd MMM yyyy").format(originalDateTime);
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => SendGroupMessageScreen(
                                groupId: groupList[index].id!
                                    .toString(),
                                groupName: groupList[index].groupName!,
                                creatorId: groupList[index].createdBy!
                                    .toString(),
                                model: groupList[index],
                              ));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                Dimensions.radiusSizeSmall),
                            color: Theme.of(context).cardColor,
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
                                          width: 60,
                                          height: 60,
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
                                                    "${Get.find<SplashController>().configModel!.baseUrls!.customerImageUrl}/${groupList[index].groupTag!}",
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
                                              groupList[index]
                                                  .groupName!,
                                              textAlign: TextAlign.center,
                                              style: walsheimBold.copyWith(
                                                fontSize: 15,
                                                color: Theme.of(context)
                                                    .focusColor,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              "Created on $formattedDate",
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
