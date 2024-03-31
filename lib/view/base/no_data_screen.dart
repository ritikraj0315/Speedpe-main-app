import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:lottie/lottie.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
class NoDataFoundScreen extends StatelessWidget {
  final bool? fromHome;
  const  NoDataFoundScreen({Key? key, this.fromHome = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return fromHome! ?  noDataWidget(context) : SizedBox(height: MediaQuery.of(context).size.height * 0.6, child: noDataWidget(context));
  }

  Padding noDataWidget(BuildContext context) {
    return Padding(
    padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.025),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Lottie.asset(
            Images.noDataAnimation,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
            animate: true, // Set to false if you don't want the animation to start immediately.
          ),

          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
          Text(
             'no_data_found'.tr, textAlign: TextAlign.center, style: walsheimMedium.copyWith(fontSize: 20, color: ColorResources.lightGrayColor),
          ),
          const SizedBox(height: 40),

        ],
      ),
    ),
  );
  }
}
