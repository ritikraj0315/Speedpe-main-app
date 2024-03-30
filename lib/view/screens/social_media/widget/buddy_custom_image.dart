import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BuddyCustomImage extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit fit;
  final String? placeholder;
  const BuddyCustomImage({Key? key, required this.image, this.height, this.width, this.fit = BoxFit.cover, this.placeholder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      //color: Theme.of(context).primaryColor,
      imageUrl: image, height: height, width: width, fit: fit,
      placeholder: (context, url) => Image.asset(placeholder!, height: height, width: width, fit: fit,),
      errorWidget: (context, url, error) => Image.asset(placeholder!, height: height, width: width, fit: fit,),
    );
  }
}