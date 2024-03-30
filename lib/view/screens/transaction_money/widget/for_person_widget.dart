import 'package:flutter/material.dart';
import 'package:six_cash/data/model/response/contact_model.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/view/screens/transaction_money/widget/preview_contact_tile.dart';

import '../../../../util/images.dart';
import '../../../base/custom_image.dart';

class ForPersonWidget extends StatelessWidget {
  final ContactModel? contactModel;
  const ForPersonWidget({Key? key, this.contactModel, }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
            child: SizedBox(
              height: 100,
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius
                    .circular(Dimensions
                    .radiusSizeOverLarge),
                child: const CustomImage(
                  fit: BoxFit.cover,
                  image: Images.avatar,
                  placeholder:
                  Images.avatar,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: PreviewContactTile(contactModel: contactModel)),
            ],
          ),
              
          //Container(height: Dimensions.dividerSizeMedium, color: Theme.of(context).cardColor),


        ],
      ),
    );
  }
}
