
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_app_bar.dart';
import 'package:six_cash/view/screens/transaction_money/pay_contacts_screen.dart';
import 'package:six_cash/view/screens/transaction_money/request_payment_screen.dart';
import 'package:six_cash/view/screens/transaction_money/transaction_money_to_bank_account_screen.dart';
import 'package:six_cash/view/screens/transaction_money/transaction_money_to_upi_screen.dart';
import '../home/widget/upi_app_logo_view.dart';

class TransactionMoneyToBankScreen extends StatefulWidget {
  const TransactionMoneyToBankScreen({Key? key}) : super(key: key);

  @override
  State<TransactionMoneyToBankScreen> createState() =>
      _TransactionMoneyToBankScreenState();
}

class _TransactionMoneyToBankScreenState
    extends State<TransactionMoneyToBankScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const CustomAppbar(title: ''),
      body: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  color: Theme.of(context).colorScheme.background,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Column(
                      children: [
                        Container(
                          height: 55,
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          //color: ColorResources.getGreyBaseGray3(),
                          child: Row(children: [
                            Text(
                              "Money transfer to A/C",
                              style: walsheimMedium.copyWith(
                                fontSize: 20,
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.9),
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            Get.to(() =>
                                const TransactionMoneyToBankAccountScreen());
                          },
                          child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    width: 0.5,
                                    style: BorderStyle.solid,
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.8)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      padding: const EdgeInsets.all(5),
                                      child: Image.asset(
                                        Images.bankIcon,
                                        color: Theme.of(context)
                                            .primaryColor, // Color of the icon
                                      ),
                                    ),
                                    Text(
                                      "Enter bank A/c details",
                                      style: walsheimMedium.copyWith(
                                          fontSize: 15,
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.9)),
                                    ),
                                    Text(
                                      "Choose Bank or IFSC details",
                                      style: walsheimMedium.copyWith(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.5)),
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
                            Get.to(() => const TransactionMoneyToUpiScreen());
                          },
                          child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    width: 0.5,
                                    style: BorderStyle.solid,
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.8)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 50,
                                          padding: const EdgeInsets.all(0),
                                          child: Image.asset(
                                            Images.rectangleUpiIcon,
                                            color: Theme.of(context)
                                                .primaryColor, // Color of the icon
                                          ),
                                        ),
                                        Container(
                                          height: 20,
                                          width: 20,
                                          padding: const EdgeInsets.all(0),
                                          child: Image.asset(
                                            Images.upiIcon, // Color of the icon
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Enter UPI ID",
                                      style: walsheimMedium.copyWith(
                                          fontSize: 15,
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.9)),
                                    ),
                                    Text(
                                      "Pay to Bank A/c using UPI ID",
                                      style: walsheimMedium.copyWith(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.5)),
                                    ),
                                  ],
                                ),
                              )
                              // Add your content for Box 1 here
                              ),
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            Get.to(() => const PayContactsScreen());
                          },
                          child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    width: 0.5,
                                    style: BorderStyle.solid,
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.8)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      padding: const EdgeInsets.all(5),
                                      child: Image.asset(
                                        Images.mobileIcon,
                                        color: Theme.of(context)
                                            .primaryColor, // Color of the icon
                                      ),
                                    ),
                                    Text(
                                      "Enter Mobile Number",
                                      style: walsheimMedium.copyWith(
                                          fontSize: 15,
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.9)),
                                    ),
                                    Text(
                                      "Direct transfer to linked a/c",
                                      style: walsheimMedium.copyWith(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.5)),
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
                            Get.to(() => const RequestPaymentScreen());
                          },
                          child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    width: 0.5,
                                    style: BorderStyle.solid,
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.8)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      padding: const EdgeInsets.all(5),
                                      child: Image.asset(
                                        Images.requestIcon,
                                        color: Theme.of(context)
                                            .primaryColor, // Color of the icon
                                      ),
                                    ),
                                    Text(
                                      "Request Payment",
                                      style: walsheimMedium.copyWith(
                                          fontSize: 15,
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.9)),
                                    ),
                                    Text(
                                      "Ask payment from friends, family etc",
                                      style: walsheimMedium.copyWith(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.5)),
                                    ),
                                  ],
                                ),
                              )
                              // Add your content for Box 1 here
                              ),
                        )),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const Column(
              children: [
                UpiAppsLogoView(),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
