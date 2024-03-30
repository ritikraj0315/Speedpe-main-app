import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:six_cash/view/screens/social_media/update_username.dart';
import '../../../../util/styles.dart';
import '../../../util/images.dart';

class WelcomeSpeedXScreen extends StatefulWidget {
  final String? phoneNumber;

  const WelcomeSpeedXScreen({Key? key, this.phoneNumber}) : super(key: key);

  @override
  State<WelcomeSpeedXScreen> createState() => _WelcomeSpeedXScreenState();
}

class _WelcomeSpeedXScreenState extends State<WelcomeSpeedXScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        width: double.infinity,
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage(Images.exploreSpeedx),
        //     // Replace with your image asset
        //     fit: BoxFit.cover, // You can adjust the fit based on your needs
        //   ),
        // ),
        padding: const EdgeInsets.fromLTRB(20, 100, 20, 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  'Welcome to\nSpeedX World.'.tr,
                  textAlign: TextAlign.start,
                  style: walsheimBold.copyWith(
                    color: Theme.of(context).focusColor,
                    fontSize: 35,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Discover groups, chat, earn rewards,\nand enjoy AI-powered experiences.'
                      .tr,
                  textAlign: TextAlign.start,
                  style: walsheimMedium.copyWith(
                    color: Theme.of(context).focusColor,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Lottie.asset(
              Images.exploreSpeedxAnimation,
              width: 280.0,
              height: 280.0,
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(const UpdateUsernameScreen());
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).indicatorColor, backgroundColor: Theme.of(context).primaryColor, padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 8,
              ),
              child: Container(
                height: 55,
                alignment: Alignment.center,
                child: Text(
                  "Get Started",
                  style: walsheimMedium.copyWith(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
