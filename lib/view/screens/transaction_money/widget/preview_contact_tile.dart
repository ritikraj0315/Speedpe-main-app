import 'package:flutter/material.dart';
import 'package:six_cash/data/model/response/contact_model.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';

class PreviewContactTile extends StatelessWidget {
  final ContactModel? contactModel;
  const PreviewContactTile({Key? key, required this.contactModel,}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    String phoneNumber = contactModel!.phoneNumber!;
    if(phoneNumber.contains('-')) {
      phoneNumber.replaceAll('-', '');
    }


    return ListTile(
        title:  Text(contactModel!.name==null?phoneNumber: contactModel!.name!, textAlign: TextAlign.center, style: walsheimBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Theme.of(context).highlightColor)),
        subtitle:phoneNumber.isEmpty? const SizedBox():
          Text(phoneNumber, textAlign: TextAlign.center, style: sFProDisplayMedium.copyWith(fontSize: 12, color: ColorResources.getGreyBaseGray1()),),
      );
  }
}



