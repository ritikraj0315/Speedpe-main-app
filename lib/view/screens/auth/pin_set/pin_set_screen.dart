import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/controller/camera_screen_controller.dart';
import 'package:six_cash/controller/create_account_controller.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/controller/verification_controller.dart';
import 'package:six_cash/data/api/api_client.dart';
import 'package:six_cash/data/model/body/signup_body.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/view/base/custom_country_code_picker.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';
import 'package:six_cash/view/screens/auth/pin_set/widget/pin_view.dart';

import '../../../../util/styles.dart';

class PinSetScreen extends StatefulWidget {
  final SignUpBody signUpBody;

  const PinSetScreen({Key? key, required this.signUpBody}) : super(key: key);

  @override
  State<PinSetScreen> createState() => _PinSetScreenState();
}

class _PinSetScreenState extends State<PinSetScreen> {
  final TextEditingController passController = TextEditingController();

  final TextEditingController confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PinView(
              passController: passController,
              confirmPassController: confirmPassController,
            ),
            Column(
              children: [
                GetBuilder<AuthController>(
                  builder: (controller) {
                    return !controller.isLoading
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSizeDefault),
                            child: ElevatedButton(
                              onPressed: () {
                                String password = passController.text.trim();
                                String confirmPassword =
                                    confirmPassController.text.trim();

                                if (password.isEmpty ||
                                    confirmPassword.isEmpty) {
                                  showCustomSnackBar('enter_your_pin'.tr);
                                } else if (password.length < 4) {
                                  showCustomSnackBar(
                                      'pin_should_be_4_digit'.tr);
                                } else if (password != confirmPassword) {
                                  showCustomSnackBar('pin_not_matched'.tr);
                                } else {
                                  String gender =
                                      Get.find<ProfileController>().gender;
                                  String countryCode =
                                      CustomCountryCodePiker.getCountryCode(
                                          Get.find<CreateAccountController>()
                                              .phoneNumber)!;
                                  String phoneNumber =
                                      Get.find<CreateAccountController>()
                                          .phoneNumber!
                                          .replaceAll(countryCode, '');
                                  File? image =
                                      Get.find<CameraScreenController>()
                                          .getImage;
                                  String? otp =
                                      Get.find<VerificationController>().otp;

                                  SignUpBody signUpBody = SignUpBody(
                                      fName: widget.signUpBody.fName,
                                      lName: widget.signUpBody.lName,
                                      gender: gender,
                                      occupation: widget.signUpBody.occupation,
                                      email: widget.signUpBody.email,
                                      phone: phoneNumber,
                                      otp: otp,
                                      password: password,
                                      dialCountryCode: countryCode);

                                  MultipartBody multipartBody =
                                      MultipartBody('image', image);
                                  Get.find<AuthController>().registration(
                                      signUpBody, [multipartBody]);
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
                                  "Confirm",
                                  style: walsheimMedium.copyWith(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: SizedBox(
                                height: 20.33,
                                width: 20.33,
                                child: CircularProgressIndicator(
                                    color: ColorResources.getLimeColor())));
                  },
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            )
          ]),
    );
  }
}
