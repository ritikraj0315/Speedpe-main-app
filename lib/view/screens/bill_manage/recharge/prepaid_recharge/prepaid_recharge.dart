import 'package:country_code_picker/country_code_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/controller/transaction_controller.dart';
import 'package:six_cash/data/model/response/contact_model.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_app_bar.dart';
import 'package:six_cash/view/base/custom_image.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';
import 'package:six_cash/view/screens/bill_manage/recharge/widget/prepaid_banner_view.dart';
import 'package:six_cash/view/screens/transaction_money/transaction_money_balance_input.dart';
import '../../../home/widget/upi_app_logo_view.dart';
import 'operator/select_prepaid_operator.dart';

class PrepaidRechargeScreen extends StatefulWidget {
  const PrepaidRechargeScreen({Key? key}) : super(key: key);

  @override
  State<PrepaidRechargeScreen> createState() => _PrepaidRechargeScreenState();
}

class _PrepaidRechargeScreenState extends State<PrepaidRechargeScreen> {
  String? customerImageBaseUrl =
      Get.find<SplashController>().configModel!.baseUrls!.customerImageUrl;
  String? _countryCode;
  final TextEditingController searchController = TextEditingController();

  void openPrepaidOperatorScreen(BuildContext context, String number) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectPrepaidOperatorScreen(number: number),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _countryCode = CountryCode.fromCountryCode(
            Get.find<SplashController>().configModel!.country!)
        .dialCode;

    if (Get.find<TransactionMoneyController>()
        .sendMoneySuggestList
        .isNotEmpty) {
    } else {
      Get.find<TransactionMoneyController>().getSuggestList(type: "send_money");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: const CustomAppbar(title: 'Mobile Recharge'),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 110,
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeDefault),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PrepaidBannerView(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Enter a phone number",
                                  style: walsheimMedium.copyWith(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.9),
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    ),
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusSizeSmall),
                        color: Theme.of(context).cardColor,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "+91",
                            style: walsheimLight.copyWith(
                              fontSize: 17,
                              color: Theme.of(context).focusColor,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              keyboardType: TextInputType.number,
                              style: walsheimLight.copyWith(
                                fontSize: 17,
                                color: Theme.of(context).focusColor,
                              ),
                              onChanged: (value) {
                                String sanitizedValue =
                                    value.replaceAll(RegExp(r'[^0-9]'), '');
                                if (sanitizedValue.length == 10) {
                                  openPrepaidOperatorScreen(context, value);
                                }
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '00000 00000'.tr,
                                hintStyle: walsheimLight.copyWith(
                                  fontSize: 17,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Theme.of(context).colorScheme.background,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.paddingSizeSmall),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.radiusSizeSmall),
                                color: Theme.of(context).cardColor,
                              ),
                              child: CustomInkWell(
                                onTap: () {},
                                radius: Dimensions.radiusSizeSmall,
                                child: DottedBorder(
                                    strokeWidth: 1.0,
                                    color: Theme.of(context).primaryColor,
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(
                                        Dimensions.radiusSizeSmall),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal:
                                              Dimensions.paddingSizeSmall,
                                          vertical:
                                              Dimensions.paddingSizeSmall),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Image.asset(
                                            Images.accountIcon,
                                            width:
                                                Dimensions.paddingSizeDefault,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: Dimensions
                                                    .paddingSizeSmall),
                                            child: Text(
                                              'Select contact'.tr,
                                              style:
                                                  walsheimMedium.copyWith(
                                                      fontSize: 13,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (searchController.text.isEmpty) {
                                  showCustomSnackBar('input_field_is_empty'.tr,
                                      isError: true);
                                } else {
                                  String phoneNumber =
                                      '$_countryCode${searchController.text.trim()}';
                                  Get.find<TransactionMoneyController>()
                                      .checkCustomerNumber(
                                          phoneNumber: phoneNumber)
                                      .then((value) {
                                    if (value!.isOk) {
                                      String? customerName =
                                          value.body['data']['name'];
                                      String? customerImage =
                                          value.body['data']['image'];
                                      Get.to(() => TransactionMoneyBalanceInput(
                                          transactionType: "send_money",
                                          contactModel: ContactModel(
                                              phoneNumber:
                                                  '$_countryCode${searchController.text.trim()}',
                                              name: customerName,
                                              avatarImage: customerImage)));
                                    }
                                  });
                                }
                              },
                              child: GetBuilder<TransactionMoneyController>(
                                  builder: (checkController) {
                                return checkController.isButtonClick
                                    ? SizedBox(
                                        width: Dimensions.radiusSizeOverLarge,
                                        height: Dimensions.radiusSizeOverLarge,
                                        child: Center(
                                            child: CircularProgressIndicator(
                                                color: Theme.of(context)
                                                    .primaryColor)))
                                    : Container(
                                        width: Dimensions.radiusSizeOverLarge,
                                        height: Dimensions.radiusSizeOverLarge,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Theme.of(context).primaryColor),
                                        child: Icon(Icons.arrow_forward,
                                            color: Theme.of(context)
                                                .indicatorColor));
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GetBuilder<TransactionMoneyController>(
                        builder: (sendMoneyController) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeSmall,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: Dimensions.paddingSizeSmall),
                              child: Text('Recent'.tr,
                                  style: walsheimMedium.copyWith(
                                      fontSize: Dimensions.fontSizeExtraLarge,
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.8))),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 100.0,
                              child: ListView.builder(
                                  itemCount: sendMoneyController
                                      .sendMoneySuggestList.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) =>
                                      CustomInkWell(
                                        radius: Dimensions.radiusSizeVerySmall,
                                        highlightColor: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .color!
                                            .withOpacity(0.3),
                                        onTap: () {
                                          sendMoneyController.suggestOnTap(
                                              index, "send_money");
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              right:
                                                  Dimensions.paddingSizeSmall),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: Dimensions
                                                    .radiusSizeOverLarge,
                                                width: Dimensions
                                                    .radiusSizeOverLarge,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius
                                                      .circular(Dimensions
                                                          .radiusSizeOverLarge),
                                                  child: CustomImage(
                                                    fit: BoxFit.cover,
                                                    image:
                                                        "$customerImageBaseUrl/${sendMoneyController.sendMoneySuggestList[index].avatarImage.toString()}",
                                                    placeholder: Images.avatar,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: Dimensions
                                                        .paddingSizeSmall),
                                                child: Text(
                                                    sendMoneyController.sendMoneySuggestList[index].name == null
                                                        ? sendMoneyController
                                                            .sendMoneySuggestList[
                                                                index]
                                                            .phoneNumber!
                                                        : sendMoneyController
                                                            .sendMoneySuggestList[
                                                                index]
                                                            .name!,
                                                    style: sendMoneyController.sendMoneySuggestList[index].name ==
                                                            null
                                                        ? walsheimMedium.copyWith(
                                                            fontSize: Dimensions
                                                                .fontSizeSmall,
                                                            color: Theme.of(context)
                                                                .focusColor
                                                                .withOpacity(0.8))
                                                        : walsheimMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).focusColor.withOpacity(0.8))),
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                            ),
                          ],
                        ),
                      );
                    })
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
        ));
  }
}
