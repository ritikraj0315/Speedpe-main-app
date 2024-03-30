import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/view/screens/history/history_screen.dart';
import 'package:six_cash/view/screens/home/home_screen.dart';
import 'package:six_cash/view/screens/profile/profile_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/screens/bill_manage/all_service_screen.dart';
import '../view/screens/social_media/speedx_home.dart';
import '../view/screens/social_media/welcome_speedx.dart';

class MenuItemController extends GetxController implements GetxService {
  int _currentTab = 0;

  int get currentTab => _currentTab;
  final List<Widget> screen = [
    const HomeScreen(),
    const AllServiceScreen(),
    HistoryScreen(),
    const ProfileScreen()
  ];
  Widget _currentScreen = const HomeScreen();

  Widget get currentScreen => _currentScreen;

  resetNavBar() {
    _currentScreen = const HomeScreen();
    _currentTab = 0;
  }

  selectHomePage({bool isUpdate = true}) {
    _currentScreen = const HomeScreen();
    _currentTab = 0;
    if (isUpdate) {
      update();
    }
  }

  selectHistoryPage() {
    _currentScreen = HistoryScreen();
    _currentTab = 1;
    update();
  }

  selectNotificationPage() {
    ProfileController profileController = Get.find<ProfileController>();
    if (profileController.userInfo!.username == null) {
      Get.to(() => const WelcomeSpeedXScreen());
    } else {
      _currentScreen = const SpeedXHomeScreen();
      _currentTab = 2;
      update();
    }
  }

  selectProfilePage() {
    // _currentScreen = const ProfileScreen();
    Get.to(() => const ProfileScreen());
    // _currentTab = 3;
    update();
  }
}
