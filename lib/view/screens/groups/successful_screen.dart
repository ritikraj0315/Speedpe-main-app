import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../util/styles.dart';
import '../../../helper/route_helper.dart';

class SuccessfulScreen extends StatefulWidget {
  const SuccessfulScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SuccessfulScreen> createState() => _SuccessfulScreenState();
}

class _SuccessfulScreenState extends State<SuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: Image.network(
                    'https://speedipay.in/storage/app/public/gifs/robolike.gif',
                    height: 120,
                    width: 120,
                    // You can set other properties such as width, height, etc.
                  ),
                ),
                Text(
                  'Group created successfully'.tr,
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
                    Navigator.popUntil(context, ModalRoute.withName(RouteHelper.navbar));
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
                      "Close",
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
    );
  }
}

Future<bool?> getBackScreen() async {
  Get.offAndToNamed(RouteHelper.navbar, arguments: false);
  return null;
}
