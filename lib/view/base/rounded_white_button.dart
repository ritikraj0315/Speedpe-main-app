import 'package:flutter/material.dart';
import 'package:six_cash/util/color_resources.dart';

import '../../util/dimensions.dart';
import '../../util/styles.dart';
import 'custom_ink_well.dart';

class RoundedWhiteButton extends StatelessWidget {
  final String? buttonText;
  final Function? onTap;
  final bool isSkip;
  const RoundedWhiteButton({Key? key, this.buttonText = '', this.onTap, this.isSkip = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorResources.getWhiteAndBlack(),
        borderRadius: BorderRadius.circular(Dimensions.radiusSizeExtraLarge),
      ),
      child: CustomInkWell(
        onTap: onTap as void Function()?,
        radius: Dimensions.radiusSizeExtraLarge,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: isSkip ? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeSmall),
          child: Text(
            buttonText!,
            style: rubikRegular.copyWith(
              color: ColorResources.getBlackAndWhite(),
              fontSize: Dimensions.fontSizeDefault,
            ),
          ),
        ),
      ),
    );
  }
}