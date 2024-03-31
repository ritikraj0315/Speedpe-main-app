import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/controller/menu_controller.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/data/model/response/user_data.dart';
import 'package:six_cash/helper/route_helper.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';
import '../../../../util/images.dart';
import '../../../base/custom_logo.dart';

class LoginScreen extends StatefulWidget {
  final String? phoneNumber;
  final String? countryCode;

  const LoginScreen({Key? key, this.phoneNumber, this.countryCode})
      : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  FocusNode phoneFocus = FocusNode();
  FocusNode passFocus = FocusNode();
  final String _heroQrTag = 'hero-qr-tag';
  String? _countryCode;
  UserData? userData;
  StreamSubscription<FGBGType>? subscription;

  void setCountryCode(String code) {
    _countryCode = code;
  }

  void setInitialCountryCode(String? code) {
    _countryCode = code;
  }

  @override
  void initState() {
    super.initState();

    subscription = FGBGEvents.stream.listen((event) {
      if (event == FGBGType.foreground) {
        Get.find<AuthController>().authenticateWithBiometric(true, null);
      }
    });

    userData = Get.find<AuthController>().getUserData();
    if (widget.phoneNumber != userData?.phone) {
      Get.find<AuthController>().removeUserData();
      userData = null;
    }

    Get.find<AuthController>().authenticateWithBiometric(true, null);

    setInitialCountryCode(widget.countryCode);
    phoneController.text = widget.phoneNumber!;
  }

  void _onKeyPressed(String value) {
    setState(() {
      pinController.text += value;
    });
  }

  void _onDeletePressed() {
    setState(() {
      if (pinController.text.isNotEmpty) {
        pinController.text =
            pinController.text.substring(0, pinController.text.length - 1);
      }
    });
  }

  void _onFingerPrintPressed() {
    Get.find<AuthController>().authenticateWithBiometric(true, null);
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: GetBuilder<AuthController>(
          builder: (authController) => AbsorbPointer(
              absorbing: authController.isLoading,
              child: Center(
                //mainAxisAlignment: MainAxisAlignment.start,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 50, horizontal: 15
                  ),
                  // width: double.infinity,
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            GetBuilder<AuthController>(builder: (controller) {
                              return Column(
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                //mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const CustomLogo(
                                    height: 100.0,
                                    width: 150.0,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  userData?.name != null
                                      ? SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: Text(
                                            userData!.name!,
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: walsheimMedium.copyWith(
                                              color:
                                                  Theme.of(context).focusColor,
                                              fontSize:
                                                  Dimensions.fontSizeSemiLarge,
                                            ),
                                          ),
                                        )
                                      : Text(
                                          'user'.tr,
                                          overflow: TextOverflow.clip,
                                          textAlign: TextAlign.start,
                                          style: walsheimMedium.copyWith(
                                            color: Theme.of(context).focusColor,
                                            fontSize: Dimensions.fontSizeSemiLarge,
                                          ),
                                        ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Verify pin to continue'.tr,
                                    textAlign: TextAlign.center,
                                    style: walsheimRegular.copyWith(
                                      color: Theme.of(context).highlightColor,
                                      fontSize: Dimensions.fontSizeDefault,
                                    ),
                                  ),
                                ],
                              );
                            }),
                            const SizedBox(
                              height: Dimensions.paddingSizeDefault,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeDefault),
                              width: 180,
                              child: PinCodeTextField(
                                length: 4,
                                obscureText: true,
                                animationType: AnimationType.fade,
                                keyboardType: TextInputType.none,
                                textStyle: walsheimMedium.copyWith(
                                    fontSize: 12,
                                    color: Theme.of(context).focusColor),
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  activeColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.5),
                                  selectedColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.5),
                                  selectedFillColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(5),
                                  fieldHeight: 40,
                                  fieldWidth: 35,
                                  borderWidth: 0.5,
                                  inactiveColor: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.5),
                                  inactiveFillColor:
                                      Theme.of(context).cardColor,
                                  activeFillColor: Theme.of(context).cardColor,
                                ),
                                animationDuration:
                                    const Duration(milliseconds: 300),
                                enableActiveFill: true,
                                controller: pinController,
                                onCompleted: (v) {
                                  _login(context, v);
                                },
                                onChanged: (value) {
                                  setState(() {});
                                },
                                beforeTextPaste: (text) {
                                  return true;
                                },
                                appContext: context,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: Dimensions.paddingSizeLarge,
                                ),
                                InkWell(
                                  onTap: () => Get.toNamed(
                                      RouteHelper.getForgetPassRoute(
                                    countryCode: _countryCode,
                                    phoneNumber: phoneController.text.trim(),
                                  )),
                                  child: Text(
                                    '${'forget_pin'.tr}?',
                                    style: walsheimRegular.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .error
                                          .withOpacity(0.7),
                                      fontSize: Dimensions.fontSizeDefault,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                                height: Dimensions.paddingSizeExtraOverLarge),
                          ],
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.only(bottom: 20, right: 10),
                            child: GetBuilder<AuthController>(
                              builder: (controller) {
                                return controller.isLoading
                                    ? CircularProgressIndicator(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color,
                                      )
                                    : const SizedBox();
                              },
                            )),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildKeyboardButton('1'),
                                _buildKeyboardButton('2'),
                                _buildKeyboardButton('3'),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildKeyboardButton('4'),
                                _buildKeyboardButton('5'),
                                _buildKeyboardButton('6'),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildKeyboardButton('7'),
                                _buildKeyboardButton('8'),
                                _buildKeyboardButton('9'),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildFingerPrintButton(),
                                _buildKeyboardButton('0'),
                                _buildDeleteButton(),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ))),
    );
  }

  Future<void> _login(BuildContext context, String password) async {
    pinController.clear();
    Get.find<MenuItemController>().resetNavBar();
    String? code = _countryCode;
    String phone = phoneController.text.trim();
    if (phone.isEmpty) {
      showCustomSnackBar('please_give_your_phone_number'.tr, isError: true);
    } else if (password.isEmpty) {
      showCustomSnackBar('please_enter_your_valid_pin'.tr, isError: true);
    } else if (password.length != 4) {
      showCustomSnackBar('pin_should_be_4_digit'.tr, isError: true);
    } else {
      try {
        await Get.find<AuthController>()
            .setUserData(UserData(phone: phone, countryCode: _countryCode));

        Get.find<AuthController>()
            .login(code: code!, phone: phone, password: password)
            .then((value) async {
          if (value.isOk) {
            await Get.find<ProfileController>().profileData(reload: true);
          }
        });
      } catch (e) {
        showCustomSnackBar('please_input_your_valid_number'.tr, isError: true);
      }
    }
  }

  Widget _buildKeyboardButton(String value) {
    return MaterialButton(
      onPressed: () => _onKeyPressed(value),
      shape: const CircleBorder(),
      child: Text(
        value,
        style: walsheimMedium.copyWith(
          color: Theme.of(context).focusColor,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return MaterialButton(
      onPressed: _onDeletePressed,
      shape: const CircleBorder(),
      child: SizedBox(
        height: 22,
        width: 22,
        child: Image.asset(
          Images.backSpaceIcon,
          color: Theme.of(context).focusColor,
        ),
      ),
    );
  }

  Widget _buildFingerPrintButton() {
    return MaterialButton(
      onPressed: _onFingerPrintPressed,
      shape: const CircleBorder(),
      child: SizedBox(
        height: 22,
        width: 22,
        child: Get.find<AuthController>().biometric
            ? Image.asset(
                Images.fingerprintIcon,
                color: Theme.of(context).focusColor,
              )
            : const SizedBox(),
      ),
    );
  }
}
