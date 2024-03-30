import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_password_field.dart';

class PinView extends StatelessWidget {
  final TextEditingController passController, confirmPassController;

  PinView(
      {Key? key,
      required this.passController,
      required this.confirmPassController})
      : super(key: key);

  final FocusNode confirmFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 100,
          Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(Dimensions.radiusSizeExtraExtraLarge),
          topRight: Radius.circular(Dimensions.radiusSizeExtraExtraLarge),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Text(
                'set_your_4_digit'.tr,
                textAlign: TextAlign.start,
                style: walsheimBold.copyWith(
                  color: Theme.of(context).focusColor,
                  fontSize: 35,
                ),
              ),
            ),
            const SizedBox(
              height: Dimensions.paddingSizeExtraLarge,
            ),
            CustomPasswordField(
              controller: passController,
              nextFocus: confirmFocus,
              isPassword: true,
              isShowSuffixIcon: true,
              isIcon: false,
              hint: 'set_your_pin'.tr,
              letterSpacing: 10.0,
            ),
            const SizedBox(
              height: Dimensions.paddingSizeExtraLarge,
            ),
            CustomPasswordField(
              controller: confirmPassController,
              focusNode: confirmFocus,
              hint: 'confirm_pin'.tr,
              isShowSuffixIcon: true,
              isPassword: true,
              isIcon: false,
              letterSpacing: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
