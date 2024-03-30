import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import '../../../history/widget/home_transaction_view_screen.dart';

class CustomExpandableContent extends StatefulWidget {
  const CustomExpandableContent({Key? key}) : super(key: key);

  @override
  State<CustomExpandableContent> createState() =>
      _CustomExpandableContentState();
}

class _CustomExpandableContentState extends State<CustomExpandableContent> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 0),
              child: Text(
                'recent_transaction'.tr,
                style: walsheimMedium.copyWith(
                  fontSize: 18,
                  color: Theme.of(context).focusColor,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 0),
            child: HomeTransactionViewScreen(
                scrollController: scrollController, isHome: true),
          ),
        ],
      ),
    );
  }
}
