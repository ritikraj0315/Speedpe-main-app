import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/localization_controller.dart';
import 'package:six_cash/util/app_constants.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_app_bar.dart';
import 'package:six_cash/view/base/custom_small_button.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';

import '../../../util/theme_provider.dart';

class ChooseTheme extends StatefulWidget {
  const ChooseTheme({Key? key}) : super(key: key);

  @override
  State<ChooseTheme> createState() => _ChooseThemeState();
}

class _ChooseThemeState extends State<ChooseTheme> {
  @override
  void initState() {
    Get.find<LocalizationController>().loadCurrentLanguage().then((index) =>
        Get.find<LocalizationController>()
            .setSelectIndex(index, isUpdate: false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppbar(title: 'Select Theme'.tr),
      body:
          GetBuilder<LocalizationController>(builder: (localizationController) {
        return Column(children: [
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final themeNotifier = ref.watch(themeProvider);
              return Expanded(
                  child: SizedBox(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    child: SizedBox(
                        child: SizedBox(
                            child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeLarge,
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                themeNotifier.setTheme(0);
                              },
                              child: Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radiusSizeSmall),
                                    color: Theme.of(context).cardColor,
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .highlightColor
                                            .withOpacity(0.1),
                                        width: 0.8,
                                        style: BorderStyle.solid),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Celadon",
                                          style: walsheimBold.copyWith(
                                            color: Theme.of(context)
                                                .highlightColor,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: ColorResources.celadonColor,
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .highlightColor
                                                    .withOpacity(0.5),
                                                width: 0.8,
                                                style: BorderStyle.solid),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                themeNotifier.setTheme(1);
                              },
                              child: Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radiusSizeSmall),
                                    color: Theme.of(context).cardColor,
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .highlightColor
                                            .withOpacity(0.1),
                                        width: 0.8,
                                        style: BorderStyle.solid),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Dark Mode",
                                          style: walsheimBold.copyWith(
                                            color: Theme.of(context)
                                                .highlightColor,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: ColorResources.blackColor,
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .highlightColor
                                                    .withOpacity(0.5),
                                                width: 0.8,
                                                style: BorderStyle.solid),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                themeNotifier.setTheme(2);
                              },
                              child: Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radiusSizeSmall),
                                    color: Theme.of(context).cardColor,
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .highlightColor
                                            .withOpacity(0.1),
                                        width: 0.8,
                                        style: BorderStyle.solid),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Lime green",
                                          style: walsheimBold.copyWith(
                                            color: Theme.of(context)
                                                .highlightColor,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: ColorResources.limeColor,
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .highlightColor
                                                    .withOpacity(0.5),
                                                width: 0.8,
                                                style: BorderStyle.solid),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                themeNotifier.setTheme(3);
                              },
                              child: Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radiusSizeSmall),
                                    color: Theme.of(context).cardColor,
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .highlightColor
                                            .withOpacity(0.1),
                                        width: 0.8,
                                        style: BorderStyle.solid),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Tumble Road Purple",
                                          style: walsheimBold.copyWith(
                                            color: Theme.of(context)
                                                .highlightColor,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: ColorResources
                                                .simplePurpleColor,
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .highlightColor
                                                    .withOpacity(0.5),
                                                width: 0.8,
                                                style: BorderStyle.solid),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              // onTap: ,
                              onTap: () {
                                themeNotifier.setTheme(4);
                              },
                              child: Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radiusSizeSmall),
                                    color: Theme.of(context).cardColor,
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .highlightColor
                                            .withOpacity(0.1),
                                        width: 0.8,
                                        style: BorderStyle.solid),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Simple Orange",
                                          style: walsheimBold.copyWith(
                                            color: Theme.of(context)
                                                .highlightColor,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: ColorResources.orangeColor,
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .highlightColor
                                                    .withOpacity(0.5),
                                                width: 0.8,
                                                style: BorderStyle.solid),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          ]),
                    ))),
                  ),
                ),
              ));
            },
          ),
          Container(
            padding: const EdgeInsets.only(
                left: Dimensions.paddingSizeDefault,
                right: Dimensions.paddingSizeDefault,
                bottom: Dimensions.paddingSizeExtraExtraLarge),
            child: Row(
              children: [
                Expanded(
                  child: CustomSmallButton(
                    onTap: () {
                      if (localizationController.languages.isNotEmpty &&
                          localizationController.selectedIndex != -1) {
                        localizationController.setLanguage(Locale(
                          AppConstants
                              .languages[localizationController.selectedIndex]
                              .languageCode!,
                          AppConstants
                              .languages[localizationController.selectedIndex]
                              .countryCode,
                        ));
                        Get.back();
                      } else {
                        showCustomSnackBar('select_a_language'.tr,
                            isError: false);
                      }
                    },
                    backgroundColor: Theme.of(context).primaryColor,
                    text: 'Update theme'.tr,
                    textColor: ColorResources.blackColor,
                  ),
                ),
              ],
            ),
          ),
        ]);
      }),
    );
  }
}
