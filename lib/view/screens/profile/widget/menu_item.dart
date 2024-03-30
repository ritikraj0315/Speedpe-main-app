import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key? key,
    required this.image,
    required this.title,
    this.iconData,
  }) : super(key: key);
  final String? image;
  final String title;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: Dimensions.paddingSizeDefault),
        child: Row(
          children: [
            SizedBox(
              width: 25,
              height: 25,
              child: image != null
                  ? Image.asset(
                      image!,
                      fit: BoxFit.contain,
                      color: Theme.of(context).focusColor.withOpacity(0.6),
                    )
                  : Icon(iconData),
            ),
            const SizedBox(width: Dimensions.paddingSizeDefault),
            Text(title,
                style: walsheimRegular.copyWith(
                    fontSize: 16,
                    color: Theme.of(context).focusColor)),
            const Spacer(),
             Icon(
              Icons.arrow_forward_ios_rounded,
              color: Theme.of(context).focusColor,
              size: Dimensions.radiusSizeDefault,
            ),
          ],
        ),
      ),
    );
  }
}
