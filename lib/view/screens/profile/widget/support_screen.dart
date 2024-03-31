import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final splashController =  Get.find<SplashController>();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppbar(title: '24_support'.tr),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeExtraOverLarge),
              child: Image.asset(Images.supportImage),
            ),

            Text('need_any_help'.tr, style: walsheimMedium.copyWith(fontSize: Dimensions.fontSizeOverOverLarge, color: Theme.of(context).highlightColor)),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
              child: Text('feel_free_to_contact'.tr, style: walsheimRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).highlightColor.withOpacity(0.5)), textAlign: TextAlign.center),
            ),


            if(splashController.configModel!.companyPhone != null)  Padding(
              padding: const EdgeInsets.only(left: Dimensions.paddingSizeLarge, right: Dimensions.paddingSizeLarge, top: Dimensions.paddingSizeOverLarge, bottom: Dimensions.paddingSizeLarge),
              child: InkWell(
                highlightColor: Theme.of(context).secondaryHeaderColor,
                onTap: () async => await launchUrl(Uri.parse('tel://${splashController.configModel!.companyPhone}')),
                child: Container(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                   // height: Dimensions.PADDING_SIZE_EXTRA_OVER_LARGE,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall), border: Border.all(color: Theme.of(context).primaryColor, width: Dimensions.dividerSizeSmall), ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                     Icon(Icons.phone, color: Theme.of(context).primaryColor,), Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                      child: Text('make_call'.tr, style: walsheimMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor)),
                    )
                  ])),
              ),
            ),

            if(splashController.configModel!.companyEmail != null) Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
              child: InkWell(
                highlightColor: Theme.of(context).secondaryHeaderColor,
                onTap: () async {
                  final Uri params = Uri(scheme: 'mailto', path: splashController.configModel!.companyEmail); String  url = params.toString();
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                  }
                },
                child: Container(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                   // height: Dimensions.PADDING_SIZE_EXTRA_OVER_LARGE,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall), color: Theme.of(context).primaryColor),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [ Icon(Icons.email, color: Theme.of(context).indicatorColor,), Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                    child: Text('send_email'.tr, style: walsheimMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).indicatorColor)),
                  )],)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
