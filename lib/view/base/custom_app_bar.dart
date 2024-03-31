import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';
import 'package:six_cash/view/base/rounded_button.dart';

import '../../util/color_resources.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function? onTap;
  final bool isSkip;
  final Function? function;
  const CustomAppbar({Key? key, required this.title, this.onTap,this.isSkip = false, this.function}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.background,
          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomInkWell(
                  onTap: onTap == null ? () {
                    Get.back();
                  } : onTap as void Function()?,
                  radius: Dimensions.radiusSizeSmall,
                  child: Container(
                    height: 40,width: 30,
                    // padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).highlightColor, width: 0.7),
                      borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: Dimensions.paddingSizeSmall,
                        color: Theme.of(context).primaryColor, // Color of the icon
                      ),
                    )
                  ),
                ),
                const SizedBox(width: Dimensions.paddingSizeDefault),
                Divider(
                  color: ColorResources.dividerColor,
                  //thickness: 2.0,
                ),
                Text(title, style: walsheimRegular.copyWith(fontSize: 18, color: Theme.of(context).focusColor),
                ),
                isSkip ? const Spacer() : const SizedBox(),
                isSkip ? SizedBox(child: RoundedButton(buttonText: 'skip'.tr, onTap: function, isSkip: true,)) : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 70);
}
