import 'package:country_code_picker/country_code_picker.dart';
import 'package:phone_number/phone_number.dart';
import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/controller/forget_password_controller.dart';
import 'package:six_cash/helper/phone_cheker.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_app_bar.dart';
import 'package:six_cash/view/base/custom_country_code_picker.dart';
import 'package:six_cash/view/base/custom_logo.dart';
import 'package:six_cash/view/base/custom_large_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';

class ForgetPassword extends StatefulWidget {
  final String? phoneNumber, countryCode;

  const ForgetPassword({Key? key, this.phoneNumber, this.countryCode})
      : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController phoneNumberController = TextEditingController();
  String? countryDialCode;

  @override
  void initState() {
    super.initState();
    countryDialCode = widget.countryCode;
    phoneNumberController.text = widget.phoneNumber!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppbar(title: 'forget_pin'.tr),
      body: Column(
        children: [
          Expanded(
            // flex: 10,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: Dimensions.paddingSizeExtraExtraLarge,
                  ),
                  const CustomLogo(
                    height: 100.0,
                    width: 150.0,
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeExtraLarge,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeExtraLarge),
                    child: Text(
                      'forget_pass_long_text'.tr,
                      style: walsheimRegular.copyWith(
                        color: Theme.of(context).focusColor,
                        fontSize: Dimensions.fontSizeLarge,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimensions.radiusSizeSmall),
                      color: Theme.of(context).cardColor,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.symmetric(
                        horizontal: Dimensions.marginSizeDefault),
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
                            controller: phoneNumberController,
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
                ],
              ),
            ),
          ),
          GetBuilder<AuthController>(builder: (controller) {
            return SizedBox(
              height: 110,
              child: !controller.isLoading
                  ? CustomLargeButton(
                      backgroundColor: Theme.of(context).primaryColor,
                      text: 'Send_for_otp'.tr,
                      onTap: () async {
                        PhoneNumber? number = await PhoneChecker.isNumberValid(
                            '$countryDialCode${phoneNumberController.text}');
                        if (number != null) {
                          Get.find<ForgetPassController>()
                              .sendForOtpResponse(phoneNumber: number.e164);
                        } else {
                          showCustomSnackBar(
                              'please_input_your_valid_number'.tr,
                              isError: true);
                        }
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor),
                    ),
            );
          }),
        ],
      ),
    );
  }
}
