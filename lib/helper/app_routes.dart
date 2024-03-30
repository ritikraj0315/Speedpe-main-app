import 'package:get/get.dart';

import '../view/screens/bill_manage/coming_soon.dart';
import '../view/screens/bill_manage/view_all_service.dart';


class AppRoutes {
  static openScreen(screenName) {
    switch (screenName) {
      case "scanAndPay":
        Get.to(() => const ComingSoonScreen());
        break;
      case "toMobileOrContacts":
        Get.to(() => const ComingSoonScreen());
        break;
      case "toSelf":
        Get.to(() => const ComingSoonScreen());
        break;
      case "toBank":
        Get.to(() => const ComingSoonScreen());
        break;
      case "balanceAndHistory":
        Get.to(() => const ComingSoonScreen());
        break;
      case "speedPeWallet":
        Get.to(() => const ComingSoonScreen());
        break;
      case "creditCards":
        Get.to(() => const ComingSoonScreen());
        break;
      case "allServices":
        Get.to(() => const ComingSoonScreen());
        break;
      case "flightTicket":
        Get.to(() => const ComingSoonScreen());
        break;
      case "busTicket":
        Get.to(() => const ComingSoonScreen());
        break;
      case "trainTicket":
        Get.to(() => const ComingSoonScreen());
        break;
      case "movieTicket":
        Get.to(() => const ComingSoonScreen());
        break;
      case "fasTagRecharge":
        Get.to(() => const ComingSoonScreen());
        break;
      case "eventTicket":
        Get.to(() => const ComingSoonScreen());
        break;
      case "metroTicket":
        Get.to(() => const ComingSoonScreen());
        break;
      case "buyFasTag":
        Get.to(() => const ComingSoonScreen());
        break;
      case "bikeInsurance":
        Get.to(() => const ComingSoonScreen());
        break;
      case "carInsurance":
        Get.to(() => const ComingSoonScreen());
        break;
      case "healthInsurance":
        Get.to(() => const ComingSoonScreen());
        break;
      case "accidentalInsurance":
        Get.to(() => const ComingSoonScreen());
        break;
      case "mobileRecharge":
        Get.to(() => const ComingSoonScreen());
        break;
      case "rentViaCreditCard":
        Get.to(() => const ComingSoonScreen());
        break;
      case "dthRecharge":
        Get.to(() => const ComingSoonScreen());
        break;
      case "electricityBill":
        Get.to(() => const ComingSoonScreen());
        break;
      case "creditCardPayment":
        Get.to(() => const ComingSoonScreen());
        break;
      case "mobilePostpaid":
        Get.to(() => const ComingSoonScreen());
        break;
      case "bookGasCylinder":
        Get.to(() => const ComingSoonScreen());
        break;
      case "viewAll":
        Get.to(() => const ViewAllServiceScreen());
        break;
      default:
        Get.to(() => const ComingSoonScreen());
    }
  }
}
