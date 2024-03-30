import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';

class CustomCard extends StatelessWidget {
  final String? image;
  final String? text;
  final VoidCallback? onTap;
  final Color? color;

  const CustomCard({Key? key, this.image, this.text, this.onTap, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
          //color: Theme.of(context).cardColor,
          //border: Border.all(color: Theme.of(context).highlightColor.withOpacity(0.1), width: 0.8, style: BorderStyle.solid),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).highlightColor.withOpacity(0.01),
                blurRadius: 40,
                offset: const Offset(0, 4))
          ]),
      child: CustomInkWell(
        onTap: onTap,
        radius: Dimensions.radiusSizeSmall,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).cardColor,
                    // border: Border.all(color: Theme.of(context).highlightColor.withOpacity(0.2), width: 0.8, style: BorderStyle.solid),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).highlightColor.withOpacity(0.1),
                          blurRadius: 40,
                          offset: const Offset(0, 4))
                    ]),
                child: SizedBox(
                    height: 25,
                    width: 25,
                    child: Image.asset(image!, fit: BoxFit.contain, color: Theme.of(context).indicatorColor.withOpacity(0.8),))),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeExtraSmall + 1),
              child: Text(
                text!,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: walsheimMedium.copyWith(
                    fontSize: 12,
                    color: Theme.of(context).indicatorColor.withOpacity(0.8)),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
