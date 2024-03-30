import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';

class UpiAppsLogoView extends StatelessWidget {
  const UpiAppsLogoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 50,),
        Text(
          'Pay anywhere with SpeedPe'.tr,
          style: walsheimLight.copyWith(
            fontSize: 10,
            color: Theme.of(context).focusColor.withOpacity(0.5),
          ),
        ),
        const SizedBox(height: 5,),
        SizedBox(
          width: 150,
          child: Image.asset(Images.upiAppsIcon),
        ),
        const SizedBox(height: 0,),
      ],
    );
  }
}
