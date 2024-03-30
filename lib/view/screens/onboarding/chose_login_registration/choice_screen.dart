import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/helper/route_helper.dart';
import 'package:six_cash/util/app_constants.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/screens/onboarding/chose_login_registration/widget/indicator_section.dart';

class ChoiceScreen extends StatelessWidget {
  const ChoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 15,
                  child: PageView.builder(
                      itemCount: AppConstants.onboardList.length,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (page) {
                        Get.find<AuthController>().change(page);
                      },
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.paddingSizeDefault),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 60,
                                      width: 60,
                                      child: Image.asset(
                                        AppConstants.onboardList[index].image,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      AppConstants.onboardList[index].title,
                                      style: walsheimBold.copyWith(
                                        color: Theme.of(context).focusColor,
                                        fontSize: 35,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    const SizedBox(
                                      height: Dimensions.paddingSizeDefault,
                                    ),
                                    Text(
                                      AppConstants.onboardList[index].subtitle,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: walsheimRegular.copyWith(
                                        color: Theme.of(context)
                                            .focusColor
                                            .withOpacity(0.7),
                                        fontSize: Dimensions.fontSizeLarge,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(
                                height: Dimensions.paddingSizeOverLarge),
                          ],
                        );
                      }),
                ),
                const IndicatorSection(),
                const SizedBox(height: Dimensions.paddingSizeDefault),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault,
                    vertical: Dimensions.paddingSizeSmall),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'By clicking Below, you agree to our ',
                        style: walsheimRegular.copyWith(
                          color: Colors.grey,
                          fontSize: 11,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Terms and Conditions',
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap =
                                  () async => Get.toNamed(RouteHelper.terms),
                          ),
                          const TextSpan(
                            text: ' & ',
                          ),
                          TextSpan(
                            text: 'privacy_policy'.tr,
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap =
                                  () async => Get.toNamed(RouteHelper.privacy),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed(RouteHelper.getRegistrationRoute());
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
                          'login_registration'.tr,
                          style: walsheimMedium.copyWith(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
