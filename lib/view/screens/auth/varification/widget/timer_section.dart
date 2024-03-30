import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/controller/verification_controller.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import '../../../../../util/color_resources.dart';

class TimerSection extends StatelessWidget {
  final String phoneNumber;
  final bool isForgetPassword;

  const TimerSection(
      {Key? key, required this.phoneNumber, required this.isForgetPassword})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return GetBuilder<VerificationController>(
          builder: (verificationController) {
        return Row(mainAxisSize: MainAxisSize.min, children: [
          Visibility(
            visible:
                verificationController.visibility && !authController.isLoading,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Didn't receive the code? ",
                    style: walsheimRegular.copyWith(
                      color: Theme.of(context).focusColor.withOpacity(0.7),
                      fontSize: Dimensions.fontSizeDefault,
                    ),
                  ),
                  TextSpan(
                    text: "Send code again", // The phone number
                    style: walsheimMedium.copyWith(
                      color: Theme.of(context).primaryColor.withOpacity(0.9),
                      fontSize: Dimensions.fontSizeDefault,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        if (isForgetPassword) {
                          authController
                              .otpForForgetPass(phoneNumber)
                              .then((value) {
                            verificationController.setVisibility(false);
                            verificationController.startTimer();
                          });
                        } else {
                          authController.checkPhone(phoneNumber).then((value) {
                            if (value.statusCode == 200) {
                              verificationController.setVisibility(false);
                              verificationController.startTimer();
                            }
                          });
                        }
                      },
                  ),
                ],
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Visibility(
              visible: !verificationController.visibility,
              child: GestureDetector(
                child: Text(
                  '${'resend_otp'.tr} ${'in'.tr} ${verificationController.maxSecond} ${'seconds'.tr}',
                  style: walsheimRegular.copyWith(
                    color: ColorResources.lightGrayColor,
                    fontSize: Dimensions.fontSizeDefault,
                  ),
                  textAlign: TextAlign.center,
                ),
              )),
        ]);
      });
    });
  }
}
