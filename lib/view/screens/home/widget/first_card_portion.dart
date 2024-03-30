import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/helper/price_converter.dart';
import 'package:six_cash/helper/transaction_type.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/screens/home/widget/custom_card.dart';
import 'package:six_cash/view/screens/home/widget/request_money_view.dart';
import 'package:six_cash/view/screens/transaction_money/transaction_money_balance_input.dart';
import '../../../../data/model/response/user_info.dart';
import '../../auth/selfie_capture/camera_screen.dart';
import '../../bill_manage/all_utility_service.dart';
import '../../groups/choose_type/choose_group_type.dart';
import '../../groups/joined_group/joined_group_screen.dart';
import '../../kyc_verify/select_kyc_method_screen.dart';
import '../../profile/widget/bootom_sheet.dart';
import '../../transaction_money/pay_contacts_screen.dart';
import '../../transaction_money/transaction_money_to_bank_screen.dart';
import '../../wallet_manage/wallet_manage.dart';
import 'banner_top_view.dart';

class FirstCardPortion extends StatelessWidget {
  const FirstCardPortion({Key? key}) : super(key: key);

  String maskPhoneNumber(String phoneNumber) {
    if (phoneNumber.length <= 4) {
      return phoneNumber;
    }
    String masked = phoneNumber.substring(0, 2); // Keep first two digits
    for (int i = 2; i < phoneNumber.length - 2; i++) {
      masked += 'X';
    }
    masked +=
        phoneNumber.substring(phoneNumber.length - 2); // Keep last two digits
    return masked;
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('ID copied to clipboard'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (splashController) {
      return Stack(children: [
        Container(
          height: 180.0,
        ),
        Positioned(
            child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                  left: Dimensions.paddingSizeDefault,
                  right: Dimensions.paddingSizeDefault,
                  top: Dimensions.paddingSizeDefault,
                  bottom: 10),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => const WalletManageScreen());
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 7.5),
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(20),
                                  bottom: Radius.circular(20)),
                              color: Theme.of(context).cardColor),
                          child: GetBuilder<ProfileController>(
                              builder: (profileController) {
                            return Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 40, left: 60),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 40,
                                                height: 40,
                                                child: SvgPicture.asset(
                                                  Images.chipIcon,
                                                  color: ColorResources
                                                      .lightGrayColor,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              SizedBox(
                                                width: 25,
                                                height: 25,
                                                child: SvgPicture.asset(
                                                  Images.signalIcon,
                                                  color: ColorResources
                                                      .lightGrayColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 8, right: 0),
                                      width: 60,
                                      height: 30,
                                      child: SvgPicture.asset(
                                        Images.rupayLogo,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 7.5),
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        child: GetBuilder<ProfileController>(
                            builder: (profileController) {
                              return Column(
                                children: [
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => const WalletManageScreen());
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          const BorderRadius.vertical(
                                              top: Radius.circular(20),
                                              bottom: Radius.circular(20)),
                                          color: Theme.of(context).cardColor),
                                      child: GetBuilder<ProfileController>(
                                          builder: (profileController) {
                                            return Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Visibility(
                                                  visible: true,
                                                  child: profileController.userInfo !=
                                                      null
                                                      ? Text(
                                                    PriceConverter
                                                        .balanceWithSymbol(
                                                        balance:
                                                        profileController
                                                            .userInfo!
                                                            .balance
                                                            .toString()),
                                                    style: sFProDisplayMedium
                                                        .copyWith(
                                                      color: Theme.of(context)
                                                          .focusColor,
                                                      fontSize: 20,
                                                    ),
                                                  )
                                                      : Text(
                                                    PriceConverter.convertPrice(
                                                        0.00),
                                                    style: sFProDisplayMedium
                                                        .copyWith(
                                                      color: Theme.of(context)
                                                          .focusColor,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Card Balance',
                                                  style: walsheimRegular.copyWith(
                                                    color: Theme.of(context)
                                                        .focusColor
                                                        .withOpacity(0.8),
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () => Get.to(const TransactionMoneyBalanceInput(
                                      transactionType: TransactionType.addMoney,
                                    )),
                                    child: Container(
                                        width: 120,
                                        height: 55,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 20),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            const BorderRadius.vertical(
                                                top: Radius.circular(15),
                                                bottom: Radius.circular(15)),
                                            color: Theme.of(context).primaryColor),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Add Money',
                                              style: walsheimMedium.copyWith(
                                                color: Theme.of(context).focusColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                      width: 120,
                                      height: 55,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(15),
                                          bottom: Radius.circular(15),
                                        ),
                                        border: Border.all(
                                          color: Theme.of(context)
                                              .primaryColor, // Border color
                                        ),
                                        color:
                                        null, // Set color to null for no background
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Manage Card',
                                            style: walsheimMedium.copyWith(
                                              color: Theme.of(context).focusColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      )),
                                ],
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const RequestMoneyView(),
            const BannerTopView(),
            const KycContainer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 40.0,
              margin: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeDefault,
                vertical: 0,
              ),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(25), bottom: Radius.circular(25)),
                  color: Theme.of(context).cardColor),
              child:
                  GetBuilder<ProfileController>(builder: (profileController) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'ID: ${maskPhoneNumber(profileController.userInfo?.phone?.replaceAll("+91", "") ?? "") ?? ""}',
                          style: walsheimRegular.copyWith(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.8),
                            fontSize: 12,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _copyToClipboard(
                                context,
                                profileController.userInfo!.phone!
                                    .replaceAll("+91", ""));
                          },
                          child: Container(
                              padding: const EdgeInsets.all(3),
                              height: 20,
                              width: 20,
                              child: Image.asset(
                                Images.copyIcon,
                                fit: BoxFit.contain,
                                color: Theme.of(context).primaryColor,
                              )),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () => showModalBottomSheet(
                        context: context,
                        backgroundColor: Theme.of(context).cardColor,
                        isScrollControlled: true,
                        isDismissible: false,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(Dimensions.radiusSizeLarge)),
                        ),
                        builder: (context) => const ProfileQRCodeBottomSheet(),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'My QR',
                            style: walsheimRegular.copyWith(
                              color:
                                  Theme.of(context).focusColor.withOpacity(0.8),
                              fontSize: 12,
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.all(3),
                              height: 20,
                              width: 20,
                              child: Image.asset(
                                Images.qrCode,
                                fit: BoxFit.contain,
                                color: Theme.of(context).primaryColor,
                              )),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
            SizedBox(
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeDefault, vertical: 10),
                  child: InkWell(
                    onTap: () {},
                    child: AnimatedContainer(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      duration: const Duration(milliseconds: 550),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (splashController
                              .configModel!.systemFeature!.sendMoneyStatus!)
                            Expanded(
                                child: CustomCard(
                              image: Images.scannerIcon,
                              text: 'Scan any\nQR code'.tr,
                              color:
                                  Theme.of(context).focusColor.withOpacity(0.5),
                              onTap: () => Get.to(() => const CameraScreen(
                                    fromEditProfile: false,
                                    isBarCodeScan: true,
                                    isHome: true,
                                  )),
                            )),
                          if (splashController
                              .configModel!.systemFeature!.cashOutStatus!)
                            Expanded(
                                child: CustomCard(
                              image: Images.sendMsgIcon,
                              text: 'Pay\ncontacts'.tr.replaceAll(' ', '\n'),
                              color: ColorResources.darkGrayColor,
                              onTap: () =>
                                  Get.to(() => const PayContactsScreen()),
                            )),
                          if (splashController.configModel!.systemFeature!
                              .sendMoneyRequestStatus!)
                            Expanded(
                                child: CustomCard(
                              image: Images.billListLogo,
                              text: 'Pay\nbills'.tr,
                              color: ColorResources.darkGrayColor,
                              onTap: () =>
                                  Get.to(() => const AllUtilityServiceScreen()),
                            )),
                          if (splashController.configModel!.systemFeature!
                              .sendMoneyRequestStatus!)
                            Expanded(
                              child: CustomCard(
                                image: Images.bankIcon,
                                text: 'Bank\ntransfer'.tr,
                                color: ColorResources.darkGrayColor,
                                onTap: () => Get.to(
                                    () => const TransactionMoneyToBankScreen()),
                              ),
                            ),
                        ],
                      ),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      Get.to(() => const ChooseGroupTypeScreen());
                    },
                    child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                                top:
                                    Radius.circular(Dimensions.radiusSizeSmall),
                                bottom: Radius.circular(
                                    Dimensions.radiusSizeSmall)),
                            color: Theme.of(context).cardColor),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Create\nGroup",
                                style: walsheimMedium.copyWith(
                                    fontSize: 18,
                                    color: Theme.of(context).indicatorColor),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          width: 1.0,
                                          style: BorderStyle.solid,
                                          color:
                                              Theme.of(context).indicatorColor),
                                    ),
                                    child: Image.asset(
                                      Images.addIcon,
                                      color: Theme.of(context).indicatorColor,
                                    ),
                                  ),
                                ],
                              )
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
                        Get.to(() => const JoinedGroupScreen());
                      },
                      child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(
                                      Dimensions.radiusSizeSmall),
                                  bottom: Radius.circular(
                                      Dimensions.radiusSizeSmall)),
                              color: Theme.of(context).cardColor),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Your\nGroups",
                                  style: walsheimMedium.copyWith(
                                      fontSize: 18,
                                      color: Theme.of(context).indicatorColor),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 40,
                                      width: 40,
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            width: 1.0,
                                            style: BorderStyle.solid,
                                            color: Theme.of(context)
                                                .indicatorColor),
                                      ),
                                      child: Image.asset(
                                        Images.rightArrowIcon,
                                        color: Theme.of(context).indicatorColor,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                          // Add your content for Box 1 here
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        )),
      ]);
    });
  }
}

class KycContainer extends StatefulWidget {
  const KycContainer({Key? key}) : super(key: key);

  @override
  State<KycContainer> createState() => _KycContainerState();
}

class _KycContainerState extends State<KycContainer> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        builder: (profileController) => Column(
              children: [
                if (profileController.userInfo?.kycStatus !=
                    KycVerification.approve)
                  Container(
                    margin: const EdgeInsets.fromLTRB(
                        0, Dimensions.paddingSizeDefault, 0, 0),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeDefault),
                        child: Container(
                            // height: 60,
                            width: double.infinity,
                            padding: const EdgeInsets.all(
                                Dimensions.paddingSizeDefault),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.radiusSizeDefault),
                                color: Theme.of(context).cardColor,
                                // border: Border.all(
                                //     color: Theme.of(context)
                                //         .highlightColor
                                //         .withOpacity(0.5),
                                //     width: 0.8,
                                //     style: BorderStyle.solid),
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context)
                                          .highlightColor
                                          .withOpacity(0.01),
                                      blurRadius: 40,
                                      offset: const Offset(0, 4))
                                ]),
                            child: InkWell(
                              onTap: () =>
                                  Get.to(() => const SelectKycMethodScreen()),
                              child: Row(
                                children: [
                                  SizedBox(
                                      height: 35,
                                      width: 35,
                                      child: Image.asset(
                                        Images.verifiedUserIcon,
                                        fit: BoxFit.contain,
                                        color: Theme.of(context).primaryColor,
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Verify Kyc!",
                                          style: walsheimBold.copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize:
                                                Dimensions.fontSizeDefault,
                                          )),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "Complete your kyc to get full access of SpeedPe.",
                                          style: walsheimRegular.copyWith(
                                            color: Theme.of(context)
                                                .focusColor
                                                .withOpacity(0.7),
                                            fontSize: Dimensions.fontSizeSmall,
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ))),
                  ),
              ],
            ));
  }
}

class ViewBalanceContainer extends StatefulWidget {
  const ViewBalanceContainer({Key? key}) : super(key: key);

  @override
  State<ViewBalanceContainer> createState() => _ViewBalanceContainerState();
}

class _ViewBalanceContainerState extends State<ViewBalanceContainer> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        builder: (profileController) => GestureDetector(
              onTap: () {
                setState(() {
                  isVisible = !isVisible;
                });
              },
              child: Column(
                children: [
                  Visibility(
                      visible: isVisible ? false : true,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                padding: EdgeInsets.zero,
                                child: Image.asset(
                                  Images.viewFilledIcon,
                                  width: 30.0,
                                  fit: BoxFit.contain,
                                  alignment: Alignment.center,
                                  color: Theme.of(context).indicatorColor,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Show Balance",
                                style: walsheimRegular.copyWith(
                                  color: Theme.of(context).indicatorColor,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      )),
                  Visibility(
                    visible: isVisible ? true : false,
                    child: profileController.userInfo != null
                        ? Text(
                            PriceConverter.balanceWithSymbol(
                                balance: profileController.userInfo!.balance
                                    .toString()),
                            style: walsheimBold.copyWith(
                              color: Theme.of(context).indicatorColor,
                              fontSize: 32,
                            ),
                          )
                        : Text(
                            PriceConverter.convertPrice(0.00),
                            style: sFProDisplayMedium.copyWith(
                              color: Theme.of(context).indicatorColor,
                              fontSize: Dimensions.fontSizeExtraLarge,
                            ),
                          ),
                  )
                ],
              ),
            ));
  }
}
