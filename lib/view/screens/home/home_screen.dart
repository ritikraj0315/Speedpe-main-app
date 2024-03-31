import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/banner_controller.dart';
import 'package:six_cash/controller/home_controller.dart';
import 'package:six_cash/controller/notification_controller.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/controller/requested_money_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/controller/transaction_controller.dart';
import 'package:six_cash/controller/transaction_history_controller.dart';
import 'package:six_cash/controller/websitelink_controller.dart';
import 'package:six_cash/view/screens/home/widget/app_bar_base.dart';
import 'package:six_cash/view/screens/home/widget/banner_bottom_view.dart';
import 'package:six_cash/view/screens/home/widget/first_card_portion.dart';
import 'package:six_cash/view/screens/home/widget/linked_website.dart';
import 'package:six_cash/view/screens/home/widget/secend_card_portion.dart';
import 'package:six_cash/view/screens/home/widget/third_card_portion.dart';
import 'package:six_cash/view/screens/home/widget/upi_app_logo_view.dart';
import 'package:six_cash/view/screens/home/widget/what_not_do_view.dart';

import '../groups/controller/group_controller.dart';
import '../wallet_manage/controller/card_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _loadData(BuildContext context, bool reload) async {
    if (reload) {
      Get.find<SplashController>().getConfigData();
    }

    Get.find<ProfileController>().profileData(reload: reload);
    Get.find<BannerController>().getBannerList(reload);
    Get.find<CardController>().getCardList(reload);
    Get.find<GroupController>().getJoinedGroupList(reload);
    Get.find<RequestedMoneyController>()
        .getRequestedMoneyList(reload, isUpdate: reload);
    Get.find<RequestedMoneyController>()
        .getOwnRequestedMoneyList(reload, isUpdate: reload);
    Get.find<TransactionHistoryController>()
        .getTransactionData(1, reload: reload);
    Get.find<WebsiteLinkController>().getWebsiteList(reload, isUpdate: reload);
    Get.find<NotificationController>()
        .getNotificationList(reload, isUpdate: reload);
    Get.find<TransactionMoneyController>()
        .getPurposeList(reload, isUpdate: reload);
    Get.find<TransactionMoneyController>().getWithdrawMethods(isReload: reload);
    Get.find<RequestedMoneyController>().getWithdrawHistoryList(reload: false);
  }

  @override
  void initState() {
    _loadData(context, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: const AppBarBase(),
        body: RefreshIndicator(
          onRefresh: () async => await _loadData(context, true),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: GetBuilder<SplashController>(builder: (splashController) {
              int themeIndex = splashController.configModel!.themeIndex ?? 1;
              return Column(children: [
                themeIndex == 1
                    ? const FirstCardPortion()
                    : themeIndex == 2
                        ? const SecondCardPortion()
                        : themeIndex == 3
                            ? const ThirdCardPortion()
                            : const FirstCardPortion(),
                //const SizedBox(height: Dimensions.paddingSizeDefault),
                // const RechargeAndBillPayments(),
              ]);
            }),
          ),
        ),
      );
    });
  }
}
