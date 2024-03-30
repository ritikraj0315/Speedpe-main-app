import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../util/styles.dart';
import '../../../helper/route_helper.dart';
import '../../../util/images.dart';

class KycVerifiedScreen extends StatefulWidget {
  const KycVerifiedScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<KycVerifiedScreen> createState() => _KycVerifiedScreenState();
}

class _KycVerifiedScreenState extends State<KycVerifiedScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 100, 20, 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Lottie.asset(
                        Images.successAnimation,
                        width: 150.0,
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                      )
                    ),
                    Text(
                      'Account Setup successfully'.tr,
                      textAlign: TextAlign.center,
                      style: walsheimBold.copyWith(
                        color: Theme.of(context).focusColor,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.popUntil(
                            context, ModalRoute.withName(RouteHelper.navbar));
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
                          "Home",
                          style: walsheimMedium.copyWith(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

Future<bool?> getBackScreen() async {
  Get.offAndToNamed(RouteHelper.navbar, arguments: false);
  return null;
}
