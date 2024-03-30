import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/view/screens/groups/successful_screen.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/styles.dart';
import '../../../util/images.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_snackbar.dart';
import 'controller/group_controller.dart';

class CreateGroupScreen extends StatefulWidget {
  final List<int> selectedUserIds;
  final String type;

  const CreateGroupScreen(
      {Key? key, required this.selectedUserIds, required this.type})
      : super(key: key);

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final TextEditingController _textFieldController = TextEditingController();
  final TextEditingController _amountTextFieldController =
      TextEditingController();
  ProfileController profileController = Get.find<ProfileController>();

  final Random _random = Random();
  List<String> groupNames = [
    'Cool Crew',
    'Mavericks',
    'Epic Explorers',
    'Dynamic Dynamos',
    'Tech Titans',
    'Power Pals',
    'Innovators',
    'Velocity Vipers',
    'Gadget Geeks',
    'Galactic Guardians',
    'Blazing Blazers',
    'Cosmic Cyclones',
    'Stealth Seekers',
    'Digital Dynasty',
    'Quantum Quest',
    'Lunar Legends',
    'Firestorm Fighters',
    'Sonic Surfers',
    'Future Fusion',
    'Magnetic Mavericks',
    'Nebula Nomads',
    'Celestial Challengers',
    'Zero Gravity Zone',
    'Pixel Pioneers',
    'Astro Adventurers',
    'Infinity Impact',
    'Hyper Heroes',
    'Starship Strikers',
    'Cosmic Crusaders',
    'Tech Trailblazers',
    'Galaxy Gliders',
    'Quantum Quasar',
    'Pixel Patrol',
    'Orbit Overlords',
    'Rocket Renegades',
    'Time Travel Tribe',
    'Astro Aviators',
    'Interstellar Icons',
    'Virtual Voyagers',
    'Cybernetic Cyclones',
    'Binary Brigade',
    'Digital Daredevils',
    'Space Sentries',
    'Robot Rovers',
    'Dimension Drifters',
    'Timeless Travelers',
  ];

  String selectedGroupName = '';

  void selectRandomGroupName() {
    setState(() {
      selectedGroupName = groupNames[_random.nextInt(groupNames.length)];
      _textFieldController.text = selectedGroupName;
    });
  }

  @override
  void initState() {
    int uniqueIdToAdd = int.parse(profileController.userInfo!.uniqueId!);

    if (!widget.selectedUserIds.contains(uniqueIdToAdd)) {

      widget.selectedUserIds.add(uniqueIdToAdd);
    }

    super.initState();
  }


  String selectedTag = '';

  void selectTag(String tag) {
    setState(() {
      selectedTag = tag;
    });
  }

  int eachAmount = 0;

  void calculateEachAmt(int amt) {
    int numberOfIds = widget.selectedUserIds.length;

    // Check if numberOfIds is not zero to avoid division by zero
    if (numberOfIds != 0) {
      eachAmount = amt ~/ numberOfIds; // Use integer division to get an integer result
      // If you want a double result, use eachAmount = amt / numberOfIds.toDouble();
    } else {
      eachAmount = 0; // Or handle this case based on your requirements
    }
  }


  createGroup() {
    String grpNme = _textFieldController.text;
    String grpTag = selectedTag.toString();

    if (_textFieldController.text.isEmpty) {
      showCustomSnackBar('Please enter group name'.tr, isError: true);
    } else if (widget.selectedUserIds.isEmpty) {
      showCustomSnackBar('Please select a member'.tr, isError: true);
    } else {
      Get.find<GroupController>()
          .createAGroup(widget.selectedUserIds, grpNme, grpTag, widget.type, eachAmount.toString())
          .then((value) {
        if (value.statusCode == 200) {
          Get.to(() => const SuccessfulScreen());
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GroupController>(builder: (groupController) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: const CustomAppbar(title: 'Create new group'),
        body: Container(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, Tell us\nAbout group.'.tr,
                        textAlign: TextAlign.start,
                        style: walsheimBold.copyWith(
                          color: Theme.of(context).focusColor,
                          fontSize: 35,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
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
                            GestureDetector(
                              onTap: () {
                                selectRandomGroupName();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                // Adjust padding for the icon
                                child: SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: Image.asset(
                                    Images.gridIcon,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextField(
                                controller: _textFieldController,
                                // inputFormatters: [
                                //   FilteringTextInputFormatter.deny(RegExp(r'\s')),
                                //   // Deny whitespace
                                // ],
                                onChanged: (value) {
                                  setState(() {
                                    // Update the filteredList based on the search query
                                    //filteredList = websiteLinkController.getSearchWebsiteList(value);
                                  });
                                },
                                keyboardType: TextInputType.name,
                                style: walsheimRegular.copyWith(
                                  fontSize: 15,
                                  color: Theme.of(context).focusColor,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Please enter group name'.tr,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(
                          'Tap above icon to see a magic.'.tr,
                          textAlign: TextAlign.start,
                          style: walsheimRegular.copyWith(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: widget.type == "payment",
                        child: Column(
                          children: [
                            Container(
                              height: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.radiusSizeSmall),
                                color: Theme.of(context).cardColor,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      //selectRandomGroupName();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      // Adjust padding for the icon
                                      child: SizedBox(
                                        height: 22,
                                        width: 22,
                                        child: Image.asset(
                                          Images.rupeeIcon,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: _amountTextFieldController,
                                      onChanged: (value) {
                                        setState(() {
                                          calculateEachAmt(int.parse(value));
                                          // Update the filteredList based on the search query
                                          //filteredList = websiteLinkController.getSearchWebsiteList(value);
                                        });
                                      },
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true),
                                      style: walsheimRegular.copyWith(
                                        fontSize: 15,
                                        color: Theme.of(context).focusColor,
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText:
                                            'Please enter total amount'.tr,
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                                'Each member have to pay ₹$eachAmount',
                                textAlign: TextAlign.start,
                                style: walsheimRegular.copyWith(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Add a Tag'.tr,
                        textAlign: TextAlign.start,
                        style: walsheimBold.copyWith(
                          color: Theme.of(context).focusColor,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          buildTagButton('Roommate'),
                          buildTagButton('Colleagues'),
                          buildTagButton('Friends'),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          buildTagButton('Family'),
                          buildTagButton('Couple'),
                          buildTagButton('Teammate'),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          buildTagButton('Work'),
                          buildTagButton('Others'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: _textFieldController.text.isNotEmpty
                        ? () {
                            createGroup();
                          }
                        : null,
                    // Set onPressed to null if selectedUserIds is empty
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
                        "Create group",
                        style: walsheimMedium.copyWith(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      );
    });
  }

  Widget buildTagButton(String tag) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            selectTag(tag);
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
                color: selectedTag == tag
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).highlightColor.withOpacity(0.01),
                      blurRadius: 40,
                      offset: const Offset(0, 4))
                ]),
            child: Text(
              tag,
              style: walsheimMedium.copyWith(
                fontSize: 15,
                color: selectedTag == tag
                    ? Theme.of(context).indicatorColor
                    : Theme.of(context).focusColor,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
