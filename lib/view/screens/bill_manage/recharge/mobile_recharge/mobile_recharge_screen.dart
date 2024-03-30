import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/transaction_controller.dart';
import '../../../../../util/color_resources.dart';
import '../../../../../util/dimensions.dart';
import '../../../../../util/styles.dart';
import '../../../../base/custom_app_bar.dart';
import '../../../../base/custom_country_code_picker.dart';
import '../../../../base/custom_small_button.dart';
import '../../../home/widget/banner_view.dart';
import '../../widget/recharge_contact_view.dart';

class MobileRechargeScreen extends StatefulWidget {
  const MobileRechargeScreen({Key? key}) : super(key: key);

  @override
  State<MobileRechargeScreen> createState() => _MobileRechargeScreenState();
}

class _MobileRechargeScreenState extends State<MobileRechargeScreen> {
  String? _countryCode;

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    final transactionMoneyController = Get.find<TransactionMoneyController>();
    //widget.fromEdit! ? searchController.text = widget.phoneNumber! : const SizedBox();

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: const CustomAppbar(title: 'Mobile Recharge'),
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
                delegate: SliverDelegate(
                    child: Column(
              children: [
                const BannerView(),
                Container(
                  padding: const EdgeInsets.fromLTRB(
                      Dimensions.paddingSizeDefault,
                      0,
                      Dimensions.paddingSizeDefault,
                      20),
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
                        child: Row(children: [
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              onChanged: (inputText) =>
                                  transactionMoneyController.searchContact(
                                searchTerm: inputText.toLowerCase(),
                              ),
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.only(
                                    top: Dimensions.paddingSizeDefault),
                                hintText: 'enter_name_or_number'.tr,
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
                              color: Theme.of(context).cardColor),
                        ]),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: Dimensions.paddingSizeDefault,
                    right: Dimensions.paddingSizeDefault,
                    bottom: Dimensions.paddingSizeDefault,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomSmallButton(
                          onTap: () => '_saveProfile(controller)',
                          backgroundColor: Theme.of(context).primaryColor,
                          text: 'Next'.tr,
                          textColor: Theme.of(context).indicatorColor,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ))),
            const RechargeContactView(),
          ],
        ));
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
  double get maxExtent => 290;

  @override
  double get minExtent => 290;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 290 ||
        oldDelegate.minExtent != 290 ||
        child != oldDelegate.child;
  }
}
