import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/controller/camera_screen_controller.dart';
import 'package:six_cash/data/model/body/signup_body.dart';
import 'package:six_cash/helper/email_checker.dart';
import 'package:six_cash/helper/route_helper.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/view/base/animated_custom_dialog.dart';
import 'package:six_cash/view/base/custom_app_bar.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';
import 'package:six_cash/view/base/my_dialog.dart';
import 'package:six_cash/view/screens/auth/other_info/widget/gender_view.dart';
import 'package:six_cash/view/screens/auth/other_info/widget/input_section.dart';

import '../../../../util/styles.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({Key? key}) : super(key: key);

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  TextEditingController occupationTextController = TextEditingController();
  TextEditingController fNameTextController = TextEditingController();
  TextEditingController lNameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _onWillPop(context).then((value) => value as bool);
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: CustomAppbar(
            title: 'information'.tr, onTap: () => _onWillPop(context)),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Expanded(
              flex: 10,
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const GenderView(),
                  InputSection(
                    occupationController: occupationTextController,
                    fNameController: fNameTextController,
                    lNameController: lNameTextController,
                    emailController: emailTextController,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraOverLarge),
                ],
              ))),
          GetBuilder<ProfileController>(builder: (getController) {
            return Container(
              margin: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  if (fNameTextController.text == '' ||
                      lNameTextController.text == '') {
                    showCustomSnackBar('first_name_or_last_name'.tr);
                  } else {
                    if (emailTextController.text != '') {
                      if (EmailChecker.isNotValid(emailTextController.text)) {
                        showCustomSnackBar(
                          'please_provide_valid_email'.tr,
                        );
                      } else {
                        Get.toNamed(RouteHelper.getPinSetRoute(
                          signUpBody: SignUpBody(
                            fName: fNameTextController.text,
                            lName: lNameTextController.text,
                            email: emailTextController.text,
                            occupation: occupationTextController.text,
                          ),
                        ));
                      }
                    } else {
                      Get.toNamed(RouteHelper.getPinSetRoute(
                        signUpBody: SignUpBody(
                          fName: fNameTextController.text,
                          lName: lNameTextController.text,
                          email: emailTextController.text,
                          occupation: occupationTextController.text,
                        ),
                      ));
                    }
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
                    'proceed'.tr,
                    style: walsheimMedium.copyWith(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            );
          })
        ]),
      ),
    );
  }

  Future _onWillPop(BuildContext context) async {
    showAnimatedDialog(
      context,
      MyDialog(
          icon: Icons.clear,
          title: 'alert'.tr,
          description: 'your_information_will_remove'.tr,
          isFailed: true,
          showTwoBtn: true,
          onTap: () {
            Get.find<CameraScreenController>().removeImage();
            Get.find<AuthController>().change(0);
            return Get.offAllNamed(RouteHelper.getSplashRoute());
          }),
      dismissible: false,
      isFlip: true,
    );
  }
}
