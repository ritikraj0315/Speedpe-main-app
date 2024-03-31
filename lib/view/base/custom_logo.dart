import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:six_cash/util/images.dart';

class CustomLogo extends StatelessWidget {
  final double? height, width;

  const CustomLogo({Key? key, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: SizedBox(
        child: SvgPicture.asset(
          Images.speedPeLogoSvg,
        ),
      ),
    );
  }
}
