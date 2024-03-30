import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/view/screens/kyc_verify/widget/kyc_method_view.dart';
import '../../../../util/styles.dart';
import '../../../util/images.dart';
import '../../base/custom_app_bar.dart';

class SelectKycMethodScreen extends StatefulWidget {
  final String? phoneNumber;

  const SelectKycMethodScreen({Key? key, this.phoneNumber}) : super(key: key);

  @override
  State<SelectKycMethodScreen> createState() => _SelectKycMethodScreenState();
}

class _SelectKycMethodScreenState extends State<SelectKycMethodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const CustomAppbar(title: ''),
      body: Center(
        // Wrap Column with Center widget
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
              child: Column(
                children: [
                  Text(
                    'Complete Account Setup'.tr,
                    textAlign: TextAlign.start,
                    style: walsheimBold.copyWith(
                      color: Theme.of(context).focusColor,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'As per RBI Guidelines, you have to verify your identity to open your account.',
                    textAlign: TextAlign.center,
                    style: walsheimLight.copyWith(
                      color: Theme.of(context).focusColor.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const KycMethodView(),
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25,
                        width: 25,
                        child: Image.asset(
                          Images.shieldUser,
                          color: Colors.green.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Trusted by 1Lakh+ Users'.tr,
                        textAlign: TextAlign.start,
                        style: walsheimMedium.copyWith(
                          color:
                              Theme.of(context).focusColor.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25,
                        width: 25,
                        child: Image.asset(
                          Images.timerIcon,
                          color: Colors.green.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Take 1 Min to complete!'.tr,
                        textAlign: TextAlign.start,
                        style: walsheimRegular.copyWith(
                          color:
                              Theme.of(context).focusColor.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ],
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
