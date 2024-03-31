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
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).highlightColor.withOpacity(0.01),
                blurRadius: 40,
                offset: const Offset(0, 4))
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomInkWell(
            radius: Dimensions.radiusSizeLarge,
            onTap: onTap,
            child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.radiusSizeLarge),
                    color: Theme.of(context).cardColor,
                    boxShadow: [
                      BoxShadow(
                          color:
                              Theme.of(context).highlightColor.withOpacity(0.1),
                          blurRadius: 40,
                          offset: const Offset(0, 4))
                    ]),
                child: SizedBox(
                    height: 25,
                    width: 25,
                    child: Image.asset(
                      image!,
                      fit: BoxFit.contain,
                      color: Theme.of(context).indicatorColor.withOpacity(0.8),
                    ))),
          ),
          const SizedBox(height: 10),
          Text(
            text!,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: walsheimMedium.copyWith(
                fontSize: 12,
                color: Theme.of(context).indicatorColor.withOpacity(0.8)),
          ),
        ],
      ),
    );
  }
}
