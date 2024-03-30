import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';

class AppbarHomeElement extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppbarHomeElement({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(height: Dimensions.paddingSizeDefault),
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: [
                ColorResources.blueButtonGradientColor, // Start color
                ColorResources.orangeButtonGradientColor, // Mid 1 color
                ColorResources.pinkButtonGradientColor, // Mid 2 color
                ColorResources.purpleButtonGradientColor, // End color
              ],
              begin: Alignment.topLeft, // Gradient start position
              end: Alignment.bottomRight, // Gradient end position
              stops: const [
                0.0,
                0.33,
                0.66,
                1.0
              ], // Position stops for each color
            ).createShader(bounds);
          },
          child: Text(
            title,
            style: walsheimBold.copyWith(
              fontSize: 22,
              color: Colors
                  .white, // Set text color to white to allow the gradient to show through
            ),
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: [
                ColorResources.blueButtonGradientColor, // Start color
                ColorResources.orangeButtonGradientColor, // Mid 1 color
                ColorResources.pinkButtonGradientColor, // Mid 2 color
                ColorResources.purpleButtonGradientColor, // End color
              ],
              begin: Alignment.topLeft, // Gradient start position
              end: Alignment.bottomRight, // Gradient end position
              stops: const [
                0.0,
                0.33,
                0.66,
                1.0
              ], // Position stops for each color
            ).createShader(bounds);
          },
          child: const Divider(
            thickness: 1,
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(80.0); // Adjust height as needed
}
