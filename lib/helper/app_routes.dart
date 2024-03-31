import 'package:get/get.dart';

import '../view/screens/bill_manage/coming_soon.dart';
import '../view/screens/bill_manage/recharge/prepaid_recharge/prepaid_recharge.dart';

class AppRoutes {
  static openScreen(screenName) {
    switch (screenName) {
      case "scanAndPay":
        Get.to(() => const ComingSoonScreen());
        break;
      case "prepaid_recharge":
        Get.to(() => const PrepaidRechargeScreen());
        break;
      default:
        Get.to(() => const ComingSoonScreen());
    }
  }
}
