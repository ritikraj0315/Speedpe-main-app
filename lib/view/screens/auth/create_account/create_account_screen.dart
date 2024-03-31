import 'package:flutter/gestures.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phone_number/phone_number.dart';
import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/controller/create_account_controller.dart';
import 'package:six_cash/util/app_constants.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_app_bar.dart';
import 'package:six_cash/view/base/custom_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';

import '../../../../helper/route_helper.dart';
import '../../../../util/images.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController numberFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppbar(title: 'login_registration'.tr),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeDefault),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150,
                          child: SvgPicture.asset(
                            Images.speedPeLogoSvg,
                          ),
                        ),
                      const SizedBox(height: 15,),
                      Text(
                        "Let's start your journey\nwith Speedpe",
                        style: walsheimBold.copyWith(
                          color: Theme.of(context).focusColor,
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],)
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeExtraLarge,
                  ),
                  GetBuilder<CreateAccountController>(
                    builder: (controller) => SizedBox(
                      height: 60,
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(Dimensions.radiusSizeSmall),
                          color: Theme.of(context).cardColor,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        margin: const EdgeInsets.symmetric(horizontal: Dimensions.marginSizeDefault),
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
                                controller: numberFieldController,
                                keyboardType: TextInputType.number,
                                style: walsheimLight.copyWith(
                                  fontSize: 17,
                                  color: Theme.of(context).focusColor,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter phone number'.tr,
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
                    ),
                  ),
                ],
              ),
            ),
          ),
          GetBuilder<AuthController>(
            builder: (controller) => SizedBox(
              height: 110,
              child: !controller.isLoading
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeDefault,
                          vertical: 0),
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
                                    ..onTap = () async =>
                                        Get.toNamed(RouteHelper.terms),
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
                                    ..onTap = () async =>
                                        Get.toNamed(RouteHelper.privacy),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              String phoneNumber =
                                  '+91${numberFieldController.text}';
                              try {
                                await PhoneNumberUtil().parse(phoneNumber).then(
                                    (value) =>
                                        Get.find<CreateAccountController>()
                                            .sendOtpResponse(
                                                number: phoneNumber));
                              } catch (e) {
                                showCustomSnackBar(
                                    'please_input_your_valid_number'.tr,
                                    isError: true);
                                numberFieldController.clear();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Theme.of(context).indicatorColor, backgroundColor: Theme.of(context).primaryColor, padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 8,
                            ),
                            child: Container(
                              height: 55,
                              alignment: Alignment.center,
                              child: Text(
                                'verify_umber'.tr,
                                style: walsheimMedium.copyWith(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          )
                        ],
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor)),
            ),
          ),
        ],
      ),
    );
  }
}
