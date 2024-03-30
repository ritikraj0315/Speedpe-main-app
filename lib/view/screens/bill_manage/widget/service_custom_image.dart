import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:six_cash/util/color_resources.dart';

class ServiceCustomImage extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit fit;
  final String? placeholder;
  const ServiceCustomImage({Key? key, required this.image, this.height, this.width, this.fit = BoxFit.cover, this.placeholder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
    color: Theme.of(context).indicatorColor.withOpacity(0.8),
      imageUrl: image, height: height, width: width, fit: fit,
      placeholder: (context, url) => Image.asset(placeholder!, height: height, width: width, fit: fit, color: Theme.of(context).primaryColor),
      errorWidget: (context, url, error) => Image.asset(placeholder!, height: height, width: width, fit: fit, color: Theme.of(context).primaryColor,),
    );
  }
}