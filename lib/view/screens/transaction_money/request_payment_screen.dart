import 'package:country_code_picker/country_code_picker.dart';
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
import 'package:six_cash/view/screens/transaction_money/transaction_money_balance_input.dart';
import 'package:six_cash/view/screens/transaction_money/widget/scan_button.dart';
import '../auth/selfie_capture/camera_screen.dart';
import '../home/widget/upi_app_logo_view.dart';

class RequestPaymentScreen extends StatefulWidget {
  const RequestPaymentScreen({Key? key}) : super(key: key);

  @override
  State<RequestPaymentScreen> createState() => _RequestPaymentScreenState();
}

class _RequestPaymentScreenState extends State<RequestPaymentScreen> {
  String? customerImageBaseUrl =
      Get.find<SplashController>().configModel!.baseUrls!.customerImageUrl;
  String? _countryCode;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _countryCode = CountryCode.fromCountryCode(
            Get.find<SplashController>().configModel!.country!)
        .dialCode;

    if (Get.find<TransactionMoneyController>()
        .requestMoneySuggestList
        .isNotEmpty) {
    } else {
      Get.find<TransactionMoneyController>()
          .getSuggestList(type: "request_money");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const CustomAppbar(title: ''),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Enter a phone number",
                                  style: walsheimMedium.copyWith(
                                    fontSize: 20,
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.9),
                                  ),
                                ),
                                Text(
                                  "Request any SpeedPe user using a phone number",
                                  style: walsheimLight.copyWith(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.5),
                                  ),
                                ),
                              ]),
                        ),
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
                    margin: const EdgeInsets.only(top: 20),
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
                          ScanButton(
                              onTap: () => Get.to(() => const CameraScreen(
                                fromEditProfile: false,
                                isBarCodeScan: true,
                                transactionType: "request_money",
                              ))),
                          InkWell(
                            onTap: () {
                              if (searchController.text.isEmpty) {
                                showCustomSnackBar('input_field_is_empty'.tr,
                                    isError: true);
                              } else {
                                String phoneNumber =
                                    '$_countryCode${searchController.text.trim()}';
                                Get.find<TransactionMoneyController>()
                                    .checkCustomerNumber(phoneNumber: phoneNumber)
                                    .then((value) {
                                  if (value!.isOk) {
                                    String? customerName =
                                    value.body['data']['name'];
                                    String? customerImage =
                                    value.body['data']['image'];
                                    Get.to(() => TransactionMoneyBalanceInput(
                                        transactionType: "request_money",
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
                                          color: Theme.of(context).primaryColor),
                                      child: Icon(Icons.arrow_forward,
                                          color:
                                          Theme.of(context).indicatorColor));
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GetBuilder<TransactionMoneyController>(
                      builder: (requestMoneyController) {
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
                                    itemCount: requestMoneyController
                                        .requestMoneySuggestList.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) => CustomInkWell(
                                      radius: Dimensions.radiusSizeVerySmall,
                                      highlightColor: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .color!
                                          .withOpacity(0.3),
                                      onTap: () {
                                        requestMoneyController.suggestOnTap(
                                            index, "request_money");
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            right: Dimensions.paddingSizeSmall),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height:
                                              Dimensions.radiusSizeOverLarge,
                                              width:
                                              Dimensions.radiusSizeOverLarge,
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    Dimensions
                                                        .radiusSizeOverLarge),
                                                child: CustomImage(
                                                  fit: BoxFit.cover,
                                                  image:
                                                  "$customerImageBaseUrl/${requestMoneyController.requestMoneySuggestList[index].avatarImage.toString()}",
                                                  placeholder: Images.avatar,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: Dimensions
                                                      .paddingSizeSmall),
                                              child: Text(
                                                  requestMoneyController.requestMoneySuggestList[index].name == null
                                                      ? requestMoneyController
                                                      .requestMoneySuggestList[
                                                  index]
                                                      .phoneNumber!
                                                      : requestMoneyController
                                                      .requestMoneySuggestList[
                                                  index]
                                                      .name!,
                                                  style: requestMoneyController.requestMoneySuggestList[index].name == null
                                                      ? walsheimMedium.copyWith(
                                                      fontSize: Dimensions
                                                          .fontSizeSmall,
                                                      color: Theme.of(context)
                                                          .focusColor
                                                          .withOpacity(0.8))
                                                      : walsheimMedium.copyWith(
                                                      fontSize:
                                                      Dimensions.fontSizeDefault,
                                                      color: Theme.of(context).focusColor.withOpacity(0.8))),
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
      )
    );
  }
}
