import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/controller/transaction_controller.dart';
import 'package:six_cash/helper/transaction_type.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_app_bar.dart';
import 'package:six_cash/view/base/custom_image.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';
import '../home/widget/upi_app_logo_view.dart';

class TransactionMoneyToBankAccountScreen extends StatefulWidget {
  final bool? fromEdit;
  final String? phoneNumber;

  const TransactionMoneyToBankAccountScreen(
      {Key? key, this.fromEdit, this.phoneNumber})
      : super(key: key);

  @override
  State<TransactionMoneyToBankAccountScreen> createState() => _TransactionMoneyToBankAccountScreenState();
}

class _TransactionMoneyToBankAccountScreenState extends State<TransactionMoneyToBankAccountScreen> {
  String? customerImageBaseUrl =
      Get.find<SplashController>().configModel!.baseUrls!.customerImageUrl;

  String? agentImageBaseUrl =
      Get.find<SplashController>().configModel!.baseUrls!.agentImageUrl;
  final ScrollController _scrollController = ScrollController();
  final String transactionType = "send_money";

  @override
  void initState() {
    super.initState();
    if (Get.find<TransactionMoneyController>().sendMoneySuggestList.isNotEmpty) {

    } else {
      Get.find<TransactionMoneyController>()
          .getSuggestList(type: transactionType);
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    final transactionMoneyController = Get.find<TransactionMoneyController>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const CustomAppbar(title: ''),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverDelegate(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  color: Theme.of(context).colorScheme.background,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeLarge),
                    child: Column(
                      children: [
                        Container(
                          height: 55,
                          padding: const EdgeInsets.symmetric(
                              vertical: 0),
                          //color: ColorResources.getGreyBaseGray3(),
                          child: Row(children: [
                            Text(
                              "Enter Bank Details",
                              style: walsheimBold.copyWith(
                                fontSize: 25,
                                color: Theme.of(context).focusColor.withOpacity(0.9),
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
          SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 180,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(Dimensions.radiusSizeSmall),
                            color: Theme.of(context).cardColor,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                // Adjust padding for the icon
                                child: SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: Image.asset(
                                    Images.bankIcon,
                                    color: Theme.of(context).primaryColor.withOpacity(0.7),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: searchController,
                                  keyboardType: TextInputType.name,
                                  style: walsheimLight.copyWith(
                                    fontSize: 15,
                                    color: Theme.of(context).focusColor,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Bank account number'.tr,
                                    hintStyle: walsheimLight.copyWith(
                                      fontSize: 15,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 15,),
                        Container(
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(Dimensions.radiusSizeSmall),
                            color: Theme.of(context).cardColor,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                // Adjust padding for the icon
                                child: SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: Image.asset(
                                    Images.bankIcon,
                                    color: Theme.of(context).primaryColor.withOpacity(0.7),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: searchController,
                                  keyboardType: TextInputType.name,
                                  style: walsheimLight.copyWith(
                                    fontSize: 15,
                                    color: Theme.of(context).focusColor,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Re-enter bank account number'.tr,
                                    hintStyle: walsheimLight.copyWith(
                                      fontSize: 15,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 15,),
                        Container(
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(Dimensions.radiusSizeSmall),
                            color: Theme.of(context).cardColor,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: Icon(
                                    Icons.location_pin,
                                    color: Theme.of(context).primaryColor.withOpacity(0.7),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: searchController,
                                  keyboardType: TextInputType.name,
                                  style: walsheimLight.copyWith(
                                    fontSize: 15,
                                    color: Theme.of(context).focusColor,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'IFSC code'.tr,
                                    hintStyle: walsheimLight.copyWith(
                                      fontSize: 15,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 15,),
                        Container(
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(Dimensions.radiusSizeSmall),
                            color: Theme.of(context).cardColor,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                // Adjust padding for the icon
                                child: SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: Image.asset(
                                    Images.profileIcon,
                                    color: Theme.of(context).primaryColor.withOpacity(0.7),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: searchController,
                                  keyboardType: TextInputType.name,
                                  style: walsheimLight.copyWith(
                                    fontSize: 15,
                                    color: Theme.of(context).focusColor,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Bank account holder name'.tr,
                                    hintStyle: walsheimLight.copyWith(
                                      fontSize: 15,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        transactionMoneyController.sendMoneySuggestList.isNotEmpty &&
                            transactionType == 'send_money'
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
                                      padding: const EdgeInsets.only(top: 15,
                                          bottom: Dimensions.paddingSizeSmall),
                                      child: Text('Recent payments'.tr,
                                          style: walsheimMedium.copyWith(
                                              fontSize: Dimensions.fontSizeSemiLarge,
                                              color:
                                              Theme.of(context).focusColor.withOpacity(0.8))),
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
                                                      index, transactionType);
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
                            transactionType == 'request_money')
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
                                              Dimensions.fontSizeSemiLarge,
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
                                                      transactionType);
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
                            transactionType == TransactionType.cashOut)
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
                                                    transactionType),
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
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          const UpiAppsLogoView(),
                          const SizedBox(height: 15,),
                          ElevatedButton(
                            onPressed: () {
                              //checkUsernameResponse(username: _textFieldController.text);
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Theme.of(context).indicatorColor, backgroundColor: Theme.of(context).primaryColor, padding: const EdgeInsets.symmetric(horizontal: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 8,
                            ),
                            child: Container(
                              height: 55,
                              alignment: Alignment.center,
                              child: Text(
                                "Continue",
                                style: walsheimMedium.copyWith(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15,),
                        ],),
                    ),
                  ],
                ),
              )
          ),
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
  double get maxExtent => 55;

  @override
  double get minExtent => 55;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 55 ||
        oldDelegate.minExtent != 55 ||
        child != oldDelegate.child;
  }
}
