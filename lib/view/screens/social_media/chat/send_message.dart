import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../controller/profile_screen_controller.dart';
import '../../../../controller/splash_controller.dart';
import '../../../../helper/date_and_time_helper.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';
import '../../../base/custom_app_bar.dart';
import '../../../base/custom_image.dart';
import '../../../base/custom_snackbar.dart';
import '../controller/socialmedia_controller.dart';
import 'model/messages_model.dart';

class SendMessageScreen extends StatefulWidget {
  final String chatId, receiverId, fName, lName;

  const SendMessageScreen(
      {Key? key,
      required this.chatId,
      required this.receiverId,
      required this.fName,
      required this.lName})
      : super(key: key);

  @override
  State<SendMessageScreen> createState() => _SendMessageScreenState();
}

class _SendMessageScreenState extends State<SendMessageScreen> {
  final TextEditingController _textFieldController = TextEditingController();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  SocialMediaController socialMediaController =
      Get.find<SocialMediaController>();
  ProfileController profileController = Get.find<ProfileController>();
  List<MessagesModel> messagesList = [];
  ScrollController scrollController = ScrollController();
  final ScrollController _scrollController = ScrollController();
  bool isAi = false;
  bool showAnimation = false;
  bool isGeneratingResponse = false;

  void sendMessage(String msg) {
    _textFieldController.clear();
    if (widget.receiverId == "13878100") {
      msgToAi(msg);
    } else {
      if (isAi) {
        getMsgFromAi(msg);
      } else {
        sendMsgToUser(msg);
      }
    }
  }

  void getMsgFromAi(String text) async {
    isGeneratingResponse = true;
    setState(() {
      socialMediaController
          .sendMessage(widget.receiverId, text.trimLeft(), "ai", text)
          .then((value) {
        if (value.statusCode == 200) {
          isGeneratingResponse = false;
          socialMediaController.getMessagesList(widget.chatId).then((values) {
            messagesList = [];
            if (values.statusCode == 200) {
              messagesList = [];
              values.body.forEach((messages) {
                messagesList.add(MessagesModel.fromJson(messages));
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
      socialMediaController
          .sendMessage(widget.receiverId, text, "user", "")
          .then((value) {
        if (value.statusCode == 200) {
          socialMediaController.getMessagesList(widget.chatId).then((values) {
            messagesList = [];
            if (values.statusCode == 200) {
              messagesList = [];
              values.body.forEach((messages) {
                messagesList.add(MessagesModel.fromJson(messages));
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

  void msgToAi(String text) {
    setState(() {
      socialMediaController
          .sendMessage(widget.receiverId, text, "user", "")
          .then((value) {
        if (value.statusCode == 200) {
          socialMediaController.getMessagesList(widget.chatId).then((values) {
            messagesList = [];
            if (values.statusCode == 200) {
              messagesList = [];
              values.body.forEach((messages) {
                messagesList.add(MessagesModel.fromJson(messages));
              });
              getMsgFromAi(text);
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
    _initLocalNotifications();
    _firebaseMessaging.subscribeToTopic('chat');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (WidgetsBinding.instance.lifecycleState != AppLifecycleState.resumed) {
        // App is in the background or terminated, show a custom notification
      }

      socialMediaController.getMessagesList(widget.chatId).then((value) {
        messagesList = [];
        if (value.statusCode == 200) {
          messagesList = [];
          value.body.forEach((messages) {
            messagesList.add(MessagesModel.fromJson(messages));
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

    socialMediaController.getMessagesList(widget.chatId).then((value) {
      messagesList = [];
      if (value.statusCode == 200) {
        messagesList = [];
        value.body.forEach((messages) {
          messagesList.add(MessagesModel.fromJson(messages));
        });
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    });
  }

  void _initLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      '870928321', // Change this to a unique channel ID
      'SpeedPe',
      importance: Importance.max,
      priority: Priority.high,
      subText: 'hey',
      tag: 'tag',
      ticker: 'New Notification',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      platformChannelSpecifics,
    );
  }

  @override
  void dispose() {
    _flutterLocalNotificationsPlugin.cancelAll();
    super.dispose();
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
    return GetBuilder<SocialMediaController>(builder: (socialMediaController) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: CustomAppbar(title: "${widget.fName} ${widget.lName}"),
        body: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: messagesList.length,
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        MessagesModel message = messagesList[index];
                        return message.senderId.toString() ==
                                profileController.userInfo!.uniqueId
                            ? Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 15),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onLongPress: () {
                                        showSheet(
                                            context,
                                            message.id.toString(),
                                            message.messageContent!);
                                      },
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                83,
                                        child: Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              51, 0, 0, 0),
                                          padding: const EdgeInsets.fromLTRB(
                                              Dimensions.paddingSizeDefault,
                                              Dimensions.paddingSizeDefault,
                                              Dimensions.paddingSizeDefault,
                                              10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Theme.of(context).cardColor,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Visibility(
                                                visible: message.type == 2,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      message.questionContent ??
                                                          'not found',
                                                      textAlign:
                                                          TextAlign.start,
                                                      softWrap: true,
                                                      style: walsheimRegular
                                                          .copyWith(
                                                        fontSize: 15,
                                                        color: Theme.of(context)
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
                                                textAlign: TextAlign.start,
                                                softWrap: true,
                                                style: walsheimRegular.copyWith(
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
                                                            message.createdAt!),
                                                    textAlign: TextAlign.end,
                                                    softWrap: true,
                                                    style: walsheimRegular
                                                        .copyWith(
                                                      fontSize: 11,
                                                      color: Theme.of(context)
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
                              )
                            : Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 15),
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
                                  crossAxisAlignment: CrossAxisAlignment.end,
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
                                        showSheet(
                                            context,
                                            message.id.toString(),
                                            message.messageContent!);
                                      },
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                83,
                                        child: Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              Dimensions.paddingSizeDefault,
                                              Dimensions.paddingSizeDefault,
                                              Dimensions.paddingSizeDefault,
                                              10),
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 51, 0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Theme.of(context).cardColor,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${message.senderFirstName!} ${message.senderLastName!}",
                                                textAlign: TextAlign.start,
                                                style: walsheimMedium.copyWith(
                                                  fontSize: 13,
                                                  color: Theme.of(context)
                                                      .focusColor,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Visibility(
                                                visible: message.type == 2,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      message.questionContent ??
                                                          'not found',
                                                      textAlign:
                                                          TextAlign.start,
                                                      softWrap: true,
                                                      style: walsheimRegular
                                                          .copyWith(
                                                        fontSize: 15,
                                                        color: Theme.of(context)
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
                                                textAlign: TextAlign.start,
                                                softWrap: true,
                                                style: walsheimRegular.copyWith(
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
                                                            message.createdAt!),
                                                    textAlign: TextAlign.end,
                                                    softWrap: true,
                                                    style: walsheimRegular
                                                        .copyWith(
                                                      fontSize: 11,
                                                      color: Theme.of(context)
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
                  Row(
                    children: [
                      Container(
                        height: 55,
                        width: (MediaQuery.of(context).size.width + 175.5) / 2,
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
}

void showSheet(context, String messageId, String messageContent) {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(Dimensions.radiusSizeLarge)),
      ),
      backgroundColor: Theme.of(context).cardColor,
      builder: (BuildContext bc) {
        //GroupController groupController = Get.find<GroupController>();
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
                      // Navigator.pop(context);
                      // _copyToClipboard(context, messageContent);
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
                          // groupController
                          //     .unsentMessage(messageId)
                          //     .then((values) {
                          //   if (values.statusCode == 200) {
                          //     groupController
                          //         .getGroupMessagesList(widget.groupId)
                          //         .then((values) {
                          //       groupMessagesList = [];
                          //       if (values.statusCode == 200) {
                          //         groupMessagesList = [];
                          //         values.body.forEach((messages) {
                          //           groupMessagesList.add(
                          //               GroupMessagesModel.fromJson(
                          //                   messages));
                          //         });
                          //       }
                          //     });
                          //   }
                          // });
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
