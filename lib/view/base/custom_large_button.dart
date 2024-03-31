
import 'package:flutter/material.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';

class CustomLargeButton extends StatelessWidget {
  final String? text;
  final Function? onTap;
  final Color? backgroundColor;
  final double bottomPadding;
  const CustomLargeButton({Key? key, 
    this.backgroundColor,
    this.onTap,
    this.text,
    this.bottomPadding = Dimensions.paddingSizeExtraOverLarge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.only(
          left: Dimensions.paddingSizeDefault,
          right: Dimensions.paddingSizeDefault,
          bottom: bottomPadding,
      ),
      child: TextButton(
        onPressed: onTap as void Function()?,
        style: TextButton.styleFrom(
          minimumSize: MediaQuery.of(context).size,
          padding: const EdgeInsets.symmetric(
              vertical: Dimensions.paddingSizeDefault),
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child:  Text(
          text!,
          style: walsheimMedium.copyWith(
            fontSize: 15,
            color: Theme.of(context).focusColor
          ),
        ),
      ),
    );
  }
}
