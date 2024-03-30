import 'dart:async';

import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:six_cash/controller/localization_controller.dart';
import 'package:six_cash/controller/theme_controller.dart';
import 'package:six_cash/helper/notification_helper.dart';
import 'package:six_cash/helper/route_helper.dart';
import 'package:six_cash/util/app_constants.dart';
import 'package:six_cash/util/color_style.dart';
import 'package:six_cash/util/messages.dart';
import 'package:six_cash/util/theme_provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'helper/get_di.dart' as di;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
late List<CameraDescription> cameras;

Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb && GetPlatform.isAndroid) {

  }

  OneSignal.initialize("989aadd6-f681-4465-b82b-ca236e6fa9e7");
  OneSignal.Notifications.requestPermission(true);
  await Firebase.initializeApp();
  cameras = await availableCameras();

  Map<String, Map<String, String>> languages = await di.init();

  int? orderID;
  try {
    if (GetPlatform.isMobile) {
      final NotificationAppLaunchDetails? notificationAppLaunchDetails =
          await flutterLocalNotificationsPlugin
              .getNotificationAppLaunchDetails();
      if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
        orderID =
            notificationAppLaunchDetails!.notificationResponse!.payload != null
                ? int.parse(
                    notificationAppLaunchDetails.notificationResponse!.payload!)
                : null;
      }
      await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
      FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    }
  } catch (e) {
    debugPrint('error ---> $e');
  }

  //runApp(MyApp(languages: languages, orderID: orderID));
  runApp(ProviderScope(child: MyApp(languages: languages, orderID: orderID)));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>>? languages;
  final int? orderID;

  MyApp({Key? key, required this.languages, required this.orderID})
      : super(key: key);

  final ColorStyle colorStyle = ColorStyle();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetBuilder<LocalizationController>(
          builder: (localizeController) {
            return Consumer(builder: (context, ref, child) {
              final themeNotifier = ref.watch(themeProvider);
              return GetMaterialApp(
                navigatorObservers: [FlutterSmartDialog.observer],
                builder: FlutterSmartDialog.init(),
                title: AppConstants.appName,
                debugShowCheckedModeBanner: false,
                navigatorKey: Get.key,
                theme: colorStyle.themeData(themeNotifier.themeIndex, context),
                locale: localizeController.locale,
                translations: Messages(languages: languages),
                fallbackLocale: Locale(AppConstants.languages[0].languageCode!,
                    AppConstants.languages[0].countryCode),
                initialRoute: RouteHelper.getSplashRoute(),
                getPages: RouteHelper.routes,
                defaultTransition: Transition.topLevel,
                transitionDuration: const Duration(milliseconds: 500),
              );
            });
          },
        );
      },
    );
  }
}
