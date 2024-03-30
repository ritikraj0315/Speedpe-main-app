import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/view/screens/groups/select_members_screen.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/styles.dart';
import '../../../base/custom_app_bar.dart';
import '../../home/widget/upi_app_logo_view.dart';
import '../controller/group_controller.dart';

class ChooseGroupTypeScreen extends StatefulWidget {
  const ChooseGroupTypeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChooseGroupTypeScreen> createState() => _ChooseGroupTypeScreenState();
}

class _ChooseGroupTypeScreenState extends State<ChooseGroupTypeScreen> {
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GroupController>(builder: (groupController) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: const CustomAppbar(title: ''),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create your group'.tr,
                    textAlign: TextAlign.start,
                    style: walsheimBold.copyWith(
                      color: Theme.of(context).focusColor,
                      fontSize: 35,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      'Your group is where you can your friends\nhangout.'.tr,
                      textAlign: TextAlign.start,
                      style: walsheimRegular.copyWith(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            Get.to(() =>  const SelectMembersScreen(type: "hangout",));
                          },
                          child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(
                                          Dimensions.radiusSizeSmall),
                                      bottom: Radius.circular(
                                          Dimensions.radiusSizeSmall)),
                                  color: ColorResources.lightPinkCardColor),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "People's\nHangout",
                                      style: walsheimMedium.copyWith(
                                          fontSize: 18,
                                          color:
                                              Theme.of(context).indicatorColor),
                                    ),
                                    Text(
                                      'Create a group to hangout with friends, family etc'
                                          .tr,
                                      textAlign: TextAlign.start,
                                      style: walsheimRegular.copyWith(
                                        color: Theme.of(context)
                                            .indicatorColor
                                            .withOpacity(0.5),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              // Add your content for Box 1 here
                              ),
                        )),
                        const SizedBox(width: 15),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() =>  const SelectMembersScreen(type: "payment",));
                            },
                            child: Container(
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(
                                            Dimensions.radiusSizeSmall),
                                        bottom: Radius.circular(
                                            Dimensions.radiusSizeSmall)),
                                    color: ColorResources.lightYellowCardColor),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Collect Payment",
                                        style: walsheimMedium.copyWith(
                                            fontSize: 18,
                                            color: Theme.of(context)
                                                .indicatorColor),
                                      ),
                                      Text(
                                        'Create a group to collect payment from friends, family etc'
                                            .tr,
                                        textAlign: TextAlign.start,
                                        style: walsheimRegular.copyWith(
                                          color: Theme.of(context)
                                              .indicatorColor
                                              .withOpacity(0.5),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                // Add your content for Box 1 here
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              const UpiAppsLogoView(),
            ],
          ),
        ),
      );
    });
  }
}
