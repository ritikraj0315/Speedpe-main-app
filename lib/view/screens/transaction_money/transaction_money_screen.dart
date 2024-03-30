import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/controller/transaction_controller.dart';
import 'package:six_cash/data/model/response/contact_model.dart';
import 'package:six_cash/helper/transaction_type.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/contact_view.dart';
import 'package:six_cash/view/base/custom_app_bar.dart';
import 'package:six_cash/view/base/custom_country_code_picker.dart';
import 'package:six_cash/view/base/custom_image.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';
import 'package:six_cash/view/screens/transaction_money/transaction_money_balance_input.dart';
import 'package:six_cash/view/screens/transaction_money/widget/scan_button.dart';

import '../auth/selfie_capture/camera_screen.dart';

class TransactionMoneyScreen extends StatefulWidget {
  final bool? fromEdit;
  final String? phoneNumber;
  final String? transactionType;

  const TransactionMoneyScreen(
      {Key? key, this.fromEdit, this.phoneNumber, this.transactionType})
      : super(key: key);

  @override
  State<TransactionMoneyScreen> createState() => _TransactionMoneyScreenState();
}

class _TransactionMoneyScreenState extends State<TransactionMoneyScreen> {
  String? customerImageBaseUrl =
      Get.find<SplashController>().configModel!.baseUrls!.customerImageUrl;

  String? agentImageBaseUrl =
      Get.find<SplashController>().configModel!.baseUrls!.agentImageUrl;
  final ScrollController _scrollController = ScrollController();
  String? _countryCode;

  @override
  void initState() {
    super.initState();

    _countryCode = CountryCode.fromCountryCode(
            Get.find<SplashController>().configModel!.country!)
        .dialCode;
    if (Get.find<TransactionMoneyController>().sendMoneySuggestList.isNotEmpty) {

    } else {
      Get.find<TransactionMoneyController>()
          .getSuggestList(type: widget.transactionType);
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    widget.fromEdit!
        ? searchController.text = widget.phoneNumber!
        : const SizedBox();
    final transactionMoneyController = Get.find<TransactionMoneyController>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppbar(title: widget.transactionType!.tr),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverDelegate(
                child: Container(
              color: Theme.of(context).colorScheme.background,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeLarge),
                child: Column(
                  children: [
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusSizeSmall),
                        color: Theme.of(context).cardColor,
                        border: Border.all(
                            color: Theme.of(context)
                                .highlightColor
                                .withOpacity(0.5),
                            width: 0.8,
                            style: BorderStyle.solid),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeDefault),
                      //color: ColorResources.getGreyBaseGray3(),
                      child: Row(children: [
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            onChanged: (inputText) =>
                                transactionMoneyController.searchContact(
                              searchTerm: inputText.toLowerCase(),
                            ),
                            keyboardType: widget.transactionType ==
                                    TransactionType.cashOut
                                ? TextInputType.phone
                                : TextInputType.name,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(top: 10),
                              hintText: widget.transactionType ==
                                      TransactionType.cashOut
                                  ? 'enter_agent_number'.tr
                                  : 'enter_name_or_number'.tr,
                              hintStyle: rubikRegular.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                                color: ColorResources.getGreyBaseGray1(),
                              ),
                              prefixIcon: CustomCountryCodePiker(
                                onChanged: (countryCode) =>
                                    _countryCode = countryCode.dialCode!,
                              ),
                            ),
                          ),
                        ),
                        Icon(Icons.search,
                            color: ColorResources.getGreyBaseGray1()),
                      ]),
                    ),
                    Container(
                      color: Theme.of(context).colorScheme.background,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            //horizontal: Dimensions.paddingSizeLarge,
                            vertical: Dimensions.paddingSizeSmall),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ScanButton(
                                onTap: () => Get.to(() => CameraScreen(
                                      fromEditProfile: false,
                                      isBarCodeScan: true,
                                      transactionType: widget.transactionType,
                                    ))),
                            InkWell(
                              onTap: () {
                                if (searchController.text.isEmpty) {
                                  showCustomSnackBar('input_field_is_empty'.tr,
                                      isError: true);
                                } else {
                                  String phoneNumber =
                                      '$_countryCode${searchController.text.trim()}';
                                  if (widget.transactionType == "cash_out") {
                                    Get.find<TransactionMoneyController>()
                                        .checkAgentNumber(
                                            phoneNumber: phoneNumber)
                                        .then((value) {
                                      if (value.isOk) {
                                        String? agentName =
                                            value.body['data']['name'];
                                        String? agentImage =
                                            value.body['data']['image'];
                                        Get.to(() => TransactionMoneyBalanceInput(
                                            transactionType:
                                                widget.transactionType,
                                            contactModel: ContactModel(
                                                phoneNumber:
                                                    '$_countryCode${searchController.text.trim()}',
                                                name: agentName,
                                                avatarImage: agentImage)));
                                      }
                                    });
                                  } else {
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
                                            transactionType:
                                                widget.transactionType,
                                            contactModel: ContactModel(
                                                phoneNumber:
                                                    '$_countryCode${searchController.text.trim()}',
                                                name: customerName,
                                                avatarImage: customerImage)));
                                      }
                                    });
                                  }
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
                    )
                  ],
                ),
              ),
            )),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                transactionMoneyController.sendMoneySuggestList.isNotEmpty &&
                        widget.transactionType == 'send_money'
                    ? GetBuilder<TransactionMoneyController>(
                        builder: (sendMoneyController) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: Dimensions.paddingSizeSmall,
                              horizontal: Dimensions.paddingSizeLarge),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: Dimensions.paddingSizeSmall),
                                child: Text('suggested'.tr,
                                    style: walsheimMedium.copyWith(
                                        fontSize: Dimensions.fontSizeExtraLarge,
                                        color:
                                            Theme.of(context).highlightColor)),
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
                                          radius:
                                              Dimensions.radiusSizeVerySmall,
                                          highlightColor: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .color!
                                              .withOpacity(0.3),
                                          onTap: () {
                                            sendMoneyController.suggestOnTap(
                                                index, widget.transactionType);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                right: Dimensions
                                                    .paddingSizeSmall),
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
                                                      placeholder:
                                                          Images.avatar,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .only(
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
                                                          ? sFProDisplayMedium.copyWith(
                                                              fontSize: Dimensions
                                                                  .fontSizeSmall,
                                                              color: Theme.of(context)
                                                                  .highlightColor)
                                                          : sFProDisplayMedium.copyWith(
                                                              fontSize: Dimensions
                                                                  .fontSizeDefault,
                                                              color: Theme.of(context).highlightColor)),
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
                    : ((transactionMoneyController
                                .requestMoneySuggestList.isNotEmpty) &&
                            widget.transactionType == 'request_money')
                        ? GetBuilder<TransactionMoneyController>(
                            builder: (requestMoneyController) {
                            return requestMoneyController.isLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: Dimensions.paddingSizeSmall,
                                        horizontal:
                                            Dimensions.paddingSizeLarge),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom:
                                                  Dimensions.paddingSizeSmall),
                                          child: Text('suggested'.tr,
                                              style: walsheimMedium.copyWith(
                                                  fontSize:
                                                      Dimensions.fontSizeLarge,
                                                  color: Theme.of(context)
                                                      .highlightColor)),
                                        ),
                                        SizedBox(
                                          height: 100.0,
                                          child: ListView.builder(
                                              itemCount: requestMoneyController
                                                  .requestMoneySuggestList
                                                  .length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder:
                                                  (context, index) =>
                                                      CustomInkWell(
                                                        radius: Dimensions
                                                            .radiusSizeVerySmall,
                                                        highlightColor:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .titleLarge!
                                                                .color!
                                                                .withOpacity(
                                                                    0.3),
                                                        onTap: () {
                                                          requestMoneyController
                                                              .suggestOnTap(
                                                                  index,
                                                                  widget
                                                                      .transactionType);
                                                        },
                                                        child: Container(
                                                          margin: const EdgeInsets
                                                              .only(
                                                              right: Dimensions
                                                                  .paddingSizeSmall),
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: Dimensions
                                                                    .radiusSizeExtraExtraLarge,
                                                                width: Dimensions
                                                                    .radiusSizeExtraExtraLarge,
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          Dimensions
                                                                              .radiusSizeOverLarge),
                                                                  child: CustomImage(
                                                                      image:
                                                                          "$customerImageBaseUrl/${requestMoneyController.requestMoneySuggestList[index].avatarImage.toString()}",
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      placeholder:
                                                                          Images
                                                                              .avatar),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .only(
                                                                    top: Dimensions
                                                                        .paddingSizeSmall),
                                                                child: Text(
                                                                    requestMoneyController.requestMoneySuggestList[index].name ==
                                                                            null
                                                                        ? requestMoneyController
                                                                            .requestMoneySuggestList[
                                                                                index]
                                                                            .phoneNumber!
                                                                        : requestMoneyController
                                                                            .requestMoneySuggestList[
                                                                                index]
                                                                            .name!,
                                                                    style: requestMoneyController.requestMoneySuggestList[index].name ==
                                                                            null
                                                                        ? rubikLight.copyWith(
                                                                            fontSize: Dimensions
                                                                                .fontSizeLarge)
                                                                        : rubikRegular.copyWith(
                                                                            fontSize:
                                                                                Dimensions.fontSizeLarge)),
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
                        : ((transactionMoneyController
                                    .cashOutSuggestList.isNotEmpty) &&
                                widget.transactionType ==
                                    TransactionType.cashOut)
                            ? GetBuilder<TransactionMoneyController>(
                                builder: (cashOutController) {
                                return cashOutController.isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical:
                                                    Dimensions.paddingSizeSmall,
                                                horizontal: Dimensions
                                                    .paddingSizeLarge),
                                            child: Text('recent_agent'.tr,
                                                style: rubikMedium.copyWith(
                                                    fontSize: Dimensions
                                                        .fontSizeLarge,
                                                    color: Theme.of(context)
                                                        .highlightColor)),
                                          ),
                                          ListView.builder(
                                              itemCount: cashOutController
                                                  .cashOutSuggestList.length,
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder:
                                                  (context, index) =>
                                                      CustomInkWell(
                                                        highlightColor:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .titleLarge!
                                                                .color!
                                                                .withOpacity(
                                                                    0.3),
                                                        onTap: () =>
                                                            cashOutController
                                                                .suggestOnTap(
                                                                    index,
                                                                    widget
                                                                        .transactionType),
                                                        child: Container(
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                              horizontal: Dimensions
                                                                  .paddingSizeLarge,
                                                              vertical: Dimensions
                                                                  .paddingSizeSmall),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SizedBox(
                                                                height: Dimensions
                                                                    .radiusSizeExtraExtraLarge,
                                                                width: Dimensions
                                                                    .radiusSizeExtraExtraLarge,
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          Dimensions
                                                                              .radiusSizeOverLarge),
                                                                  child:
                                                                      CustomImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    image:
                                                                        "$agentImageBaseUrl/${cashOutController.cashOutSuggestList[index].avatarImage.toString()}",
                                                                    placeholder:
                                                                        Images
                                                                            .avatar,
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: Dimensions
                                                                    .paddingSizeSmall,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      cashOutController.cashOutSuggestList[index].name ==
                                                                              null
                                                                          ? 'Unknown'
                                                                          : cashOutController
                                                                              .cashOutSuggestList[
                                                                                  index]
                                                                              .name!,
                                                                      style: rubikRegular.copyWith(
                                                                          fontSize: Dimensions
                                                                              .fontSizeLarge,
                                                                          color: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyLarge!
                                                                              .color)),
                                                                  Text(
                                                                    cashOutController.cashOutSuggestList[index].phoneNumber !=
                                                                            null
                                                                        ? cashOutController
                                                                            .cashOutSuggestList[index]
                                                                            .phoneNumber!
                                                                        : 'No Number',
                                                                    style: rubikLight.copyWith(
                                                                        fontSize:
                                                                            Dimensions
                                                                                .fontSizeDefault,
                                                                        color: ColorResources
                                                                            .getGreyBaseGray1()),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )),
                                        ],
                                      );
                              })
                            : const SizedBox(),
              ],
            ),
          ),
          ContactView(transactionType: widget.transactionType)
        ],
      ),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;

  SliverDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 130;

  @override
  double get minExtent => 130;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 130 ||
        oldDelegate.minExtent != 130 ||
        child != oldDelegate.child;
  }
}
