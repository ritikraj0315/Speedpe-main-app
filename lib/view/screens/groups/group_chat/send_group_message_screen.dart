import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/view/screens/groups/group_details/group_details_screen.dart';

import '../../../../controller/profile_screen_controller.dart';
import '../../../../controller/splash_controller.dart';
import '../../../../helper/date_and_time_helper.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';
import '../../../base/custom_image.dart';
import '../../../base/custom_snackbar.dart';
import '../controller/group_controller.dart';
import '../joined_group/model/joined_group_model.dart';
import 'model/group_message_model.dart';

class SendGroupMessageScreen extends StatefulWidget {
  final String groupId, groupName, creatorId;
  final JoinedGroupModel model;

  const SendGroupMessageScreen(
      {Key? key,
      required this.groupId,
      required this.groupName,
      required this.creatorId,
      required this.model})
      : super(key: key);

  @override
  State<SendGroupMessageScreen> createState() => _SendGroupMessageScreenState();
}

class _SendGroupMessageScreenState extends State<SendGroupMessageScreen> {
  final TextEditingController _textFieldController = TextEditingController();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  GroupController groupController = Get.find<GroupController>();
  ProfileController profileController = Get.find<ProfileController>();
  List<GroupMessagesModel> groupMessagesList = [];
  ScrollController scrollController = ScrollController();
  final ScrollController _scrollController = ScrollController();
  bool isAi = false;
  bool showAnimation = false;
  bool isGeneratingResponse = false;
  Map<String, dynamic> memberDetail = {};

  void sendMessage(String msg) {
    _textFieldController.clear();
    if (isAi) {
      getMsgFromAi(msg);
    } else {
      sendMsgToUser(msg);
    }
  }

  void getMsgFromAi(String text) async {
    isGeneratingResponse = true;
    setState(() {
      groupController
          .sendGroupMessage(widget.groupId, text, "ai", text)
          .then((value) {
        if (value.statusCode == 200) {
          isGeneratingResponse = false;
          groupController.getGroupMessagesList(widget.groupId).then((values) {
            groupMessagesList = [];
            if (values.statusCode == 200) {
              groupMessagesList = [];
              values.body.forEach((messages) {
                groupMessagesList.add(GroupMessagesModel.fromJson(messages));
              });
            }
          });
        } else {
          isGeneratingResponse = false;
        }
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    });
  }

  void sendMsgToUser(String text) {
    setState(() {
      groupController
          .sendGroupMessage(widget.groupId, text, "user", "")
          .then((value) {
        if (value.statusCode == 200) {
          groupController.getGroupMessagesList(widget.groupId).then((values) {
            groupMessagesList = [];
            if (values.statusCode == 200) {
              groupMessagesList = [];
              values.body.forEach((messages) {
                groupMessagesList.add(GroupMessagesModel.fromJson(messages));
              });
            }
          });
        }
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _firebaseMessaging.subscribeToTopic('chat');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (WidgetsBinding.instance.lifecycleState != AppLifecycleState.resumed) {
        // App is in the background or terminated, show a custom notification
      }

      groupController.getGroupMessagesList(widget.groupId).then((value) {
        groupMessagesList = [];
        if (value.statusCode == 200) {
          groupMessagesList = [];
          value.body.forEach((messages) {
            groupMessagesList.add(GroupMessagesModel.fromJson(messages));
          });
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottom();
        });
      });
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle launching the app via a notification
      // You may want to navigate to a specific screen or handle the payload
    });

    groupController.getMemberDetails(widget.groupId).then((value) {
      if (value.statusCode == 200) {
        memberDetail = value.body;
      }
    });
    groupController.getGroupMessagesList(widget.groupId).then((value) {
      groupMessagesList = [];
      if (value.statusCode == 200) {
        groupMessagesList = [];
        value.body.forEach((messages) {
          groupMessagesList.add(GroupMessagesModel.fromJson(messages));
        });
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    });
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GroupController>(builder: (groupController) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: MyAppBar(
          title: widget.groupName,
          adminId: widget.creatorId,
          grpId: widget.groupId,
          memberType: memberDetail['member_type']?.toString() ?? '1',
          model: widget.model,
        ),
        body: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: groupMessagesList.isEmpty
                        ? Center(
                            child: Text(
                              "No messages found!",
                              style: walsheimRegular.copyWith(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: groupMessagesList.length,
                            controller: _scrollController,
                            itemBuilder: (context, index) {
                              GroupMessagesModel message =
                                  groupMessagesList[index];
                              return message.senderId.toString() ==
                                      profileController.userInfo!.uniqueId
                                  ? Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 15),
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
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onLongPress: () {
                                              showMenuSheet(
                                                  context,
                                                  message.id!.toString(),
                                                  message.messageContent!);
                                            },
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  83,
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        51, 0, 0, 0),
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        Dimensions
                                                            .paddingSizeDefault,
                                                        Dimensions
                                                            .paddingSizeDefault,
                                                        Dimensions
                                                            .paddingSizeDefault,
                                                        10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Theme.of(context)
                                                      .cardColor,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Visibility(
                                                      visible:
                                                          message.type == 2,
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            message.questionContent ??
                                                                'not found',
                                                            textAlign:
                                                                TextAlign.start,
                                                            softWrap: true,
                                                            style:
                                                                walsheimRegular
                                                                    .copyWith(
                                                              fontSize: 15,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Text(
                                                      message.messageContent!,
                                                      textAlign:
                                                          TextAlign.start,
                                                      softWrap: true,
                                                      style: walsheimRegular
                                                          .copyWith(
                                                        fontSize: 15,
                                                        color: Theme.of(context)
                                                            .hintColor,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          DateAndTimeHelper
                                                              .formatRelativeTime(
                                                                  message
                                                                      .createdAt!),
                                                          textAlign:
                                                              TextAlign.end,
                                                          softWrap: true,
                                                          style: walsheimRegular
                                                              .copyWith(
                                                            fontSize: 11,
                                                            color: Theme.of(
                                                                    context)
                                                                .hintColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 15),
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
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: InkWell(
                                              onTap: () {},
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: CustomImage(
                                                  image:
                                                      "${Get.find<SplashController>().configModel!.baseUrls!.customerImageUrl}/${message.senderImage}",
                                                  placeholder: Images.avatar,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          GestureDetector(
                                            onLongPress: () {
                                              showMenuSheet(
                                                  context,
                                                  message.id!.toString(),
                                                  message.messageContent!);
                                            },
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  83,
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 51, 0),
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        Dimensions
                                                            .paddingSizeDefault,
                                                        Dimensions
                                                            .paddingSizeDefault,
                                                        Dimensions
                                                            .paddingSizeDefault,
                                                        10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Theme.of(context)
                                                      .cardColor,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${message.senderFirstName!} ${message.senderLastName!}",
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: walsheimMedium
                                                          .copyWith(
                                                        fontSize: 13,
                                                        color: Theme.of(context)
                                                            .focusColor,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Visibility(
                                                      visible:
                                                          message.type == 2,
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            message.questionContent ??
                                                                'not found',
                                                            textAlign:
                                                                TextAlign.start,
                                                            softWrap: true,
                                                            style:
                                                                walsheimRegular
                                                                    .copyWith(
                                                              fontSize: 15,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Text(
                                                      message.messageContent!,
                                                      textAlign:
                                                          TextAlign.start,
                                                      softWrap: true,
                                                      style: walsheimRegular
                                                          .copyWith(
                                                        fontSize: 15,
                                                        color: Theme.of(context)
                                                            .hintColor,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          DateAndTimeHelper
                                                              .formatRelativeTime(
                                                                  message
                                                                      .createdAt!),
                                                          textAlign:
                                                              TextAlign.end,
                                                          softWrap: true,
                                                          style: walsheimRegular
                                                              .copyWith(
                                                            fontSize: 11,
                                                            color: Theme.of(
                                                                    context)
                                                                .hintColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                            },
                          ),
                  ),
                  (widget.model.isGroupOpen != 2 ||
                          memberDetail['member_type'] == 2)
                      ? Row(
                          children: [
                            Container(
                              height: 55,
                              width:
                                  (MediaQuery.of(context).size.width + 175.5) /
                                      2,
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
                                  InkWell(
                                    onTap: () {
                                      setState(() {});
                                    },
                                    onLongPress: () {
                                      setState(() {
                                        isAi = !isAi;
                                        //if (isAi) {
                                        showAnimationForOneSecond();
                                        //}
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: SizedBox(
                                        height: 22,
                                        width: 22,
                                        child: Image.asset(
                                          isAi
                                              ? Images.robotIcon
                                              : Images.addSquareIcon,
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
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      style: walsheimRegular.copyWith(
                                        fontSize: 15,
                                        color: Theme.of(context).focusColor,
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: isAi
                                            ? 'Message SpeedX Ai'
                                            : " Type message",
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
                                  String message = _textFieldController.text;
                                  if (message.isEmpty) {
                                    showCustomSnackBar('Please enter a message',
                                        isError: true);
                                  } else {
                                    sendMessage(message);
                                  }
                                },
                                child: ClipRRect(
                                  child: Image.asset(
                                    Images.sendMsgIcon,
                                    color: Theme.of(context).indicatorColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(
                          height: 20,
                          child: RichText(
                            textAlign: TextAlign.start,
                            softWrap: true,
                            text: TextSpan(
                              style: walsheimRegular.copyWith(
                                fontSize: 13,
                                color: Theme.of(context).focusColor,
                              ),
                              children: [
                                const TextSpan(
                                  text: 'Only ',
                                ),
                                TextSpan(
                                  text: 'admins',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .primaryColor, // Set your desired color here
                                    fontWeight: FontWeight
                                        .bold, // Set other styles if needed
                                  ),
                                ),
                                const TextSpan(
                                  text: ' can send message',
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
              if (isGeneratingResponse)
                Positioned(
                  width: MediaQuery.of(context).size.width - 32,
                  bottom: 100,
                  child: Center(
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radiusSizeSmall),
                          color: Theme.of(context).cardColor,
                          border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 1.0,
                              style: BorderStyle.solid),
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context)
                                    .highlightColor
                                    .withOpacity(0.01),
                                blurRadius: 40,
                                offset: const Offset(0, 4))
                          ]),
                      child: Lottie.asset(
                        Images.horizontalLoadingAnimation,
                        animate:
                            true, // Set to false if you don't want the animation to start immediately.
                      ),
                    ),
                  ),
                ),
              if (showAnimation)
                Center(
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    child: Center(
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: Image.asset(
                          isAi ? Images.robotIcon : Images.messageTextIcon,
                          color: Theme.of(context).primaryColor,
                        ),
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

  void showAnimationForOneSecond() {
    setState(() {
      showAnimation = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        showAnimation = false;
      });
    });
  }

  void showMenuSheet(context, String messageId, String messageContent) {
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
                        _copyToClipboard(context, messageContent);
                      },
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            height: 30,
                            width: 30,
                            child: Image.asset(
                              Images.copyIcon,
                              color:
                                  Theme.of(context).focusColor.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Copy message",
                            textAlign: TextAlign.start,
                            style: walsheimRegular.copyWith(
                              color: Theme.of(context).focusColor,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            groupController
                                .unsentMessage(messageId)
                                .then((values) {
                              if (values.statusCode == 200) {
                                groupController
                                    .getGroupMessagesList(widget.groupId)
                                    .then((values) {
                                  groupMessagesList = [];
                                  if (values.statusCode == 200) {
                                    groupMessagesList = [];
                                    values.body.forEach((messages) {
                                      groupMessagesList.add(
                                          GroupMessagesModel.fromJson(
                                              messages));
                                    });
                                  }
                                });
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
                                  color: ColorResources.lightRedColor
                                      .withOpacity(0.7),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Unsent message",
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
                    ),
                    Container(height: 20),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

void _copyToClipboard(BuildContext context, String text) {
  Clipboard.setData(ClipboardData(text: text));
  // Optionally, you can provide feedback to the user
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Text copied to clipboard'),
    ),
  );
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String adminId;
  final String grpId;
  final String memberType;
  final JoinedGroupModel model;

  const MyAppBar({
    Key? key,
    required this.title,
    required this.adminId,
    required this.grpId,
    required this.model,
    required this.memberType,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.find<ProfileController>();
    return AppBar(
      title: Text(
        title,
        style: walsheimBold.copyWith(
            fontSize: 20, color: Theme.of(context).focusColor),
      ),
      actions: [
        Visibility(
          visible: true,
          child: IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Get.to(() => GroupDetailsScreen(
                    groupId: grpId,
                    memberType: memberType,
                    model: model,
                  ));
            },
          ),
        ),
      ],
    );
  }
}
