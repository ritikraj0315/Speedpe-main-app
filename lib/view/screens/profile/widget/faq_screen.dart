import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/faq_controller.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_app_bar.dart';
import 'package:six_cash/view/screens/profile/widget/shimmer/faq_shimmer.dart';

class FaqScreen extends StatefulWidget {
  final String title;
  const FaqScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();

}

class _FaqScreenState extends State<FaqScreen> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    Get.find<FaqController>().getFaqList();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppbar(title: widget.title),
      body: GetBuilder<FaqController>(builder: (faqController) {
        return faqController.isLoading ? const FaqShimmer() :
             ListView.builder(
            itemCount: faqController.helpTopics!.length,
            itemBuilder: (ctx, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExpansionTile(
                    iconColor: Theme.of(context).primaryColor,
                    collapsedIconColor: Theme.of(context).primaryColor,
                    title: Text(faqController.helpTopics![index].question!,
                        style: sFProDisplaySemiBold.copyWith(
                            color: Theme.of(context).highlightColor)),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(faqController.helpTopics![index].answer!,
                            style: sFProDisplayMedium.copyWith(color: Theme.of(context).highlightColor.withOpacity(0.5)),
                            textAlign: TextAlign.justify),
                      )
                    ],
                  ),
                ],
              );
            });
      }),
    );
  }
}
