import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/view/screens/wallet_manage/widget/card_list_view.dart';
import '../../../../helper/route_helper.dart';
import '../../../controller/profile_screen_controller.dart';
import '../../../helper/price_converter.dart';
import '../../../helper/transaction_type.dart';
import '../../../util/color_resources.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/styles.dart';
import '../../base/custom_app_bar.dart';
import '../home/widget/bottom_sheet/expandable_content.dart';
import '../home/widget/upi_app_logo_view.dart';
import '../transaction_money/transaction_money_balance_input.dart';
import 'cards/add_card.dart';

class WalletManageScreen extends StatefulWidget {
  const WalletManageScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<WalletManageScreen> createState() => _WalletManageScreenState();
}

class _WalletManageScreenState extends State<WalletManageScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const CustomAppbar(title: ''),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                //width: MediaQuery.sizeOf(context).width * .78,
                height: 100.0,
                margin: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(Dimensions.radiusSizeSmall),
                        bottom: Radius.circular(Dimensions.radiusSizeSmall)),
                    color: Theme.of(context).cardColor),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const AddCardScreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeDefault,
                        ),
                        child: GetBuilder<ProfileController>(
                            builder: (profileController) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'your_balance'.tr,
                                    style: walsheimRegular.copyWith(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.5),
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: Image.asset(
                                      Images.rightArrowIcon,
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Visibility(
                                visible: true,
                                child: profileController.userInfo != null
                                    ? Text(
                                        PriceConverter.balanceWithSymbol(
                                            balance: profileController
                                                .userInfo!.balance
                                                .toString()),
                                        style: walsheimBold.copyWith(
                                          color: Theme.of(context).focusColor,
                                          fontSize: 15,
                                        ),
                                      )
                                    : Text(
                                        PriceConverter.convertPrice(0.00),
                                        style: walsheimMedium.copyWith(
                                          color: Theme.of(context).focusColor,
                                          fontSize:
                                              Dimensions.fontSizeExtraLarge,
                                        ),
                                      ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                    //const Spacer(),
                    const SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(const TransactionMoneyBalanceInput(
                              transactionType: TransactionType.addMoney,
                            ));
                          },
                          child: Container(
                            height: 35,
                            padding: const EdgeInsets.fromLTRB(5,0,10,0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
                              gradient: LinearGradient(
                                colors: [
                                  ColorResources.blueButtonGradientColor,     // Start color
                                  ColorResources.orangeButtonGradientColor,     // Mid 1 color
                                  ColorResources.pinkButtonGradientColor,   // Mid 2 color
                                  ColorResources.purpleButtonGradientColor,  // End color
                                ],
                                begin: Alignment.topLeft,    // Gradient start position
                                end: Alignment.bottomRight,  // Gradient end position
                                stops: const [0.0, 0.33, 0.66, 1.0], // Position stops for each color
                              ),
                            ),
                            //width: (MediaQuery.of(context).size.width - 6) / 4,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Image.asset(
                                    Images.addIcon,
                                    color: Theme.of(context).focusColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 0,
                                ),
                                Text(
                                  "Add Money",
                                  style: walsheimMedium.copyWith(
                                    fontSize: 11,
                                    color: Theme.of(context).focusColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const CardListView(),
              const CustomExpandableContent(),
              const UpiAppsLogoView(),
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool?> getBackScreen() async {
  Get.offAndToNamed(RouteHelper.navbar, arguments: false);
  return null;
}
