import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../util/images.dart';
import '../../../util/styles.dart';
import '../../base/custom_app_bar.dart';

class ComingSoonScreen extends StatefulWidget {
  const ComingSoonScreen({Key? key}) : super(key: key);

  @override
  State<ComingSoonScreen> createState() => _ComingSoonScreenState();
}

class _ComingSoonScreenState extends State<ComingSoonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const CustomAppbar(title: 'Coming Soon'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              Images.catSleepingAnimation,
              width: 280.0,
              height: 180.0,
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
            Text("404 not found",
                style: walsheimBold.copyWith(
                    fontSize: 20, color: Theme.of(context).focusColor)),
          ],
        ),
      ),
    );
  }
}
