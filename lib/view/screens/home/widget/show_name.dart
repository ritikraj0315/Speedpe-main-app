import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';

class ShowName extends StatelessWidget {
  const ShowName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GetBuilder<ProfileController>(
          builder: (controller) => controller.userInfo != null
              ? RichText(
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            '${'hi'.tr} ', // Assuming 'hi'.tr gets translated text
                        style: walsheimRegular.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                      TextSpan(
                        text: '${controller.userInfo!.fName}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.fontSizeLarge,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                )
              : RichText(
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            '${'hi'.tr} ', // Assuming 'hi'.tr gets translated text
                        style: walsheimRegular.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                      TextSpan(
                        text: 'User',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.fontSizeLarge,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
