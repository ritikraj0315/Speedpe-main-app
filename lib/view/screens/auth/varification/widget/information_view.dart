import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/create_account_controller.dart';
import 'package:six_cash/controller/verification_controller.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';

class InformationView extends StatelessWidget {
  final String? phoneNumber;

  const InformationView({Key? key, this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String getLastFourDigits(String phoneNumber) {
      String numericPhoneNumber = phoneNumber.replaceAll(RegExp(r'\D+'), '');
      String lastFourDigits = numericPhoneNumber.substring(
          numericPhoneNumber.length - 4, numericPhoneNumber.length);
      return lastFourDigits;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault),
          padding:
              const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
          child: Text(
            'Phone Number\nVerification'.tr,
            style: walsheimBold.copyWith(
              color: ColorResources.getBlackAndWhite(),
              fontSize: Dimensions.fontSizeExtraOverLarge,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        if (phoneNumber != null && phoneNumber != 'null')
          Container(
            margin: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeDefault),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "You've received a one-time code to the number\nending on ${getLastFourDigits(phoneNumber!)}. ",
                        style: walsheimRegular.copyWith(
                          color: Theme.of(context).focusColor.withOpacity(0.7),
                          fontSize: Dimensions.fontSizeDefault,
                        ),
                      ),
                      TextSpan(
                        text: "(Change)", // The phone number
                        style: walsheimRegular.copyWith(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.9),
                            fontSize: Dimensions.fontSizeDefault,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.back();
                          },
                      ),
                    ],
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        if (phoneNumber == null || phoneNumber == 'null')
          GetBuilder<CreateAccountController>(
              builder: (createAccountController) =>
                  createAccountController.phoneNumber != null
                      ? Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeDefault),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          "You've received a one-time code to the number\nending on ${getLastFourDigits(createAccountController.phoneNumber!)}. ",
                                      style: walsheimRegular.copyWith(
                                        color: Theme.of(context)
                                            .focusColor
                                            .withOpacity(0.7),
                                        fontSize: Dimensions.fontSizeDefault,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "(Change)", // The phone number
                                      style: walsheimRegular.copyWith(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.9),
                                          fontSize: Dimensions.fontSizeDefault,
                                          decoration: TextDecoration.underline),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.back();
                                          Get.find<VerificationController>()
                                              .cancelTimer();
                                          Get.find<VerificationController>()
                                              .setVisibility(false);
                                        },
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        )
                      : const SizedBox()),
      ],
    );
  }
}
