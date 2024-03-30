import 'package:lottie/lottie.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../util/images.dart';
import '../../../../../util/styles.dart';

class ComingSoonDialog extends StatelessWidget {
  const ComingSoonDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Material(
          color: Theme.of(context).colorScheme.background,
          elevation: 2,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: GetBuilder<ProfileController>(
                builder: (controller) {
                  return SizedBox(
                    //  height: MediaQuery.of(context).size.height*0.4,
                    // width: MediaQuery.of(context).size.width*0.8,
                    // child: Image.asset( Images.qrImage,
                    //   fit: BoxFit.contain,),
                      child: SizedBox(
                        height: 250,
                        child: Column(

                          children: [
                            Lottie.asset(
                              Images.comingSoonAnimation,
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                              animate:
                              true, // Set to false if you don't want the animation to start immediately.
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Page Coming Soon",
                              style: sFProDisplayMedium.copyWith(
                                color: Theme.of(context).highlightColor,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),)
                  );
                },
              )),
        ),
      ),
    );
  }
}
