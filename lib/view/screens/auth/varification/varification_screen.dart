import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/controller/create_account_controller.dart';
import 'package:six_cash/controller/verification_controller.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/view/base/custom_app_bar.dart';
import 'package:six_cash/view/screens/auth/varification/widget/information_view.dart';
import 'package:six_cash/view/screens/auth/varification/widget/timer_section.dart';

import '../../../../util/styles.dart';
import '../../home/widget/upi_app_logo_view.dart';

class VerificationScreen extends StatefulWidget {
  final String? phoneNumber;
  final String? userType;
  final String? countryCode;
  final String? nationalNumber;

  const VerificationScreen(
      {Key? key,
      this.phoneNumber,
      this.userType,
      this.countryCode,
      this.nationalNumber})
      : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  void initState() {
    Get.find<VerificationController>().startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isForgetPassword = widget.phoneNumber != null;
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: CustomAppbar(
            title: ''.tr,
            onTap: () {
              Get.find<VerificationController>().cancelTimer();
              Get.back();
            }),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InformationView(phoneNumber: widget.phoneNumber),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    const SizedBox(
                      height: Dimensions.paddingSizeSmall,
                    ),
                    GetBuilder<VerificationController>(
                        builder: (verificationController) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeDefault),
                        width: 220,
                        child: PinCodeTextField(
                          length: 4,
                          obscureText: false,
                          animationType: AnimationType.fade,
                          keyboardType: TextInputType.phone,
                          textStyle: walsheimMedium.copyWith(
                              fontSize: 15,
                              color: Theme.of(context).focusColor),
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            activeColor:
                                Theme.of(context).primaryColor.withOpacity(0.5),
                            selectedColor:
                                Theme.of(context).primaryColor.withOpacity(0.5),
                            selectedFillColor:
                                Theme.of(context).primaryColor.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 45,
                            borderWidth: 0.5,
                            inactiveColor:
                                Theme.of(context).focusColor.withOpacity(0.5),
                            inactiveFillColor: Theme.of(context).cardColor,
                            activeFillColor: Theme.of(context).cardColor,
                          ),
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          onCompleted: (v) {
                            verificationController.setOtp(v);
                            String? phoneNumber = isForgetPassword
                                ? widget.phoneNumber
                                : Get.find<CreateAccountController>()
                                    .phoneNumber!;
                            if (isForgetPassword) {
                              Get.find<AuthController>()
                                  .verificationForForgetPass(phoneNumber, v);
                            } else if (widget.userType == 'customer') {
                              Get.find<AuthController>().phoneLoginVerify(
                                  phoneNumber!,
                                  v,
                                  widget.countryCode!,
                                  widget.nationalNumber!);
                            } else {
                              Get.find<AuthController>()
                                  .phoneVerify(phoneNumber!, v);
                            }
                          },
                          onChanged: (value) {
                            setState(() {});
                          },
                          beforeTextPaste: (text) {
                            return true;
                          },
                          appContext: context,
                        ),
                      );
                    }),
                    const SizedBox(
                      height: Dimensions.paddingSizeSmall,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeDefault),
                      child: TimerSection(
                        isForgetPassword: isForgetPassword,
                        phoneNumber: widget.phoneNumber ??
                            Get.find<CreateAccountController>().phoneNumber!,
                      ),
                    ),
                  ],
                ),
              )),
              GetBuilder<AuthController>(
                  builder: (controller) => SizedBox(
                        height: 100,
                        child: controller.isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                    color: ColorResources.getLimeColor()),
                              )
                            : const SizedBox(),
                      )),
              const SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UpiAppsLogoView(),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
