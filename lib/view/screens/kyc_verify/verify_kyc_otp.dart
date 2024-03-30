import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../util/styles.dart';
import '../../../controller/kyc_verify_controller.dart';
import '../../../controller/profile_screen_controller.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_snackbar.dart';

class VerifyKycOtpScreen extends StatefulWidget {
  const VerifyKycOtpScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<VerifyKycOtpScreen> createState() => _VerifyKycOtpScreenState();
}

class _VerifyKycOtpScreenState extends State<VerifyKycOtpScreen> {
  int _secondsRemaining = 60;
  Timer? _timer;

  final TextEditingController _fieldOtp = TextEditingController();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  void resendOTP() {
    setState(() {
      _secondsRemaining = 60;
    });
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const CustomAppbar(title: ''),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Verify OTP'.tr,
                  textAlign: TextAlign.start,
                  style: walsheimBold.copyWith(
                    color: Theme.of(context).focusColor,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'OTP has been sent to you registered mobile number.',
                  textAlign: TextAlign.center,
                  style: walsheimLight.copyWith(
                    color: Theme.of(context).focusColor.withOpacity(0.5),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  textStyle: walsheimMedium.copyWith(
                      fontSize: 15, color: Theme.of(context).focusColor),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    activeColor: Theme.of(context).primaryColor,
                    selectedColor: Theme.of(context).primaryColor,
                    selectedFillColor: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 50,
                    borderWidth: 0.5,
                    inactiveColor: Theme.of(context).focusColor,
                    inactiveFillColor: Theme.of(context).cardColor,
                    activeFillColor: Theme.of(context).cardColor,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  controller: _fieldOtp,
                  onCompleted: (v) {},
                  onChanged: (value) {
                    setState(() {});
                  },
                  beforeTextPaste: (text) {
                    return true;
                  },
                  appContext: context,
                ),
                Column(
                  children: [
                    _secondsRemaining > 0
                        ? Text(
                            "Resend OTP in $_secondsRemaining seconds",
                            style: walsheimMedium.copyWith(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.7)),
                          )
                        : Row(
                            children: [
                              Text(
                                "Request again! ",
                                style: walsheimMedium.copyWith(
                                    fontSize: 14,
                                    color: Theme.of(context).focusColor),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Text(
                                  "Click here",
                                  style: walsheimMedium.copyWith(
                                      fontSize: 14, color: Colors.green),
                                ),
                              )
                            ],
                          ),
                  ],
                ),
              ],
            ),
            Center(
              child: Get.find<KycVerifyController>().isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_fieldOtp.text.isEmpty) {
                            showCustomSnackBar('Please enter otp'.tr);
                          } else {
                            Get.find<KycVerifyController>()
                                .kycVerifyOtp(_fieldOtp.text)
                                .then((value) {
                              Get.find<ProfileController>()
                                  .profileData(isUpdate: true, reload: true);
                            });
                          }
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
                            "Verify",
                            style: walsheimMedium.copyWith(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
