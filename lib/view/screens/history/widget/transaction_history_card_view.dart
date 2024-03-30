import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/localization_controller.dart';
import 'package:six_cash/data/model/transaction_model.dart';
import 'package:six_cash/helper/date_converter.dart';
import 'package:six_cash/helper/price_converter.dart';
import 'package:six_cash/helper/transaction_type.dart';
import 'package:six_cash/util/app_constants.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';

class TransactionHistoryCardView extends StatelessWidget {
  final Transactions? transactions;

  const TransactionHistoryCardView({Key? key, this.transactions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? userPhone;
    String? userName;
    bool isCredit = transactions!.transactionType == AppConstants.sendMoney ||
        transactions!.transactionType == AppConstants.withdraw ||
        transactions!.transactionType == TransactionType.cashOut;

    try {
      userPhone = transactions!.transactionType == AppConstants.sendMoney
          ? transactions!.receiver!.phone
          : transactions!.transactionType == AppConstants.receivedMoney
              ? transactions!.sender!.phone
              : (transactions!.transactionType == AppConstants.addMoney ||
                      transactions!.transactionType == 'add_money_bonus')
                  ? transactions!.sender!.phone
                  : transactions!.transactionType == AppConstants.cashIn
                      ? transactions!.sender!.phone
                      : transactions!.transactionType == AppConstants.withdraw
                          ? transactions!.receiver!.phone
                          : transactions!.userInfo!.phone;

      userName = transactions!.transactionType == AppConstants.sendMoney
          ? transactions!.receiver!.name
          : transactions!.transactionType == AppConstants.receivedMoney
              ? transactions!.sender!.name
              : (transactions!.transactionType == AppConstants.addMoney ||
                      transactions!.transactionType == 'add_money_bonus')
                  ? transactions!.sender!.name
                  : transactions!.transactionType == AppConstants.cashIn
                      ? transactions!.sender!.name
                      : transactions!.transactionType == AppConstants.withdraw
                          ? transactions!.receiver!.name
                          : transactions!.userInfo!.name;
    } catch (e) {
      userPhone = 'no_user'.tr;
      userName = 'no_user'.tr;
    }

    return Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        //color: Theme.of(context).primaryColor,
                        height: 50,
                        width: 50,
                        padding: const EdgeInsets.all(2.0),
                        child: transactions!.transactionType == null
                            ? const SizedBox()
                            : Image.asset(Images.getTransactionImage(
                                transactions!.transactionType)),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                              visible: false,
                              child: Text(
                                transactions!.transactionType!.tr,
                                style: rubikMedium.copyWith(
                                    fontSize: Dimensions.fontSizeDefault,
                                    color: Theme.of(context).highlightColor),
                              ),
                            ),
                            const SizedBox(
                                height: Dimensions.paddingSizeSuperExtraSmall),
                            Text(
                              userName ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: walsheimBold.copyWith(
                                  fontSize: Dimensions.fontSizeDefault,
                                  color: Theme.of(context).focusColor.withOpacity(0.8)),
                            ),
                            const SizedBox(
                                height: Dimensions.paddingSizeSuperExtraSmall),
                            Text(
                              userPhone ?? '',
                              style: rubikMedium.copyWith(
                                  fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context).highlightColor),
                            ),
                            const SizedBox(
                                height: Dimensions.paddingSizeSuperExtraSmall),
                            Text(
                              'TrxID: ${transactions!.transactionId}',
                              style: rubikRegular.copyWith(
                                  fontSize: Dimensions.fontSizeExtraSmall,
                                  color: Theme.of(context).highlightColor),
                            ),
                          ]),
                      const Spacer(),
                      Text(
                        '${isCredit ? '-' : '+'} ${PriceConverter.convertPrice(double.parse(transactions!.amount.toString()))}',
                        style: rubikMedium.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          color: isCredit ? Colors.redAccent : Colors.green,
                        ),
                      ),
                    ],
                  ),
                  //const SizedBox(height: 10),

                  //Divider(height: .125,color: ColorResources.getGreyColor()),
                ],
              ),
              Get.find<LocalizationController>().isLtr
                  ? Positioned(
                      bottom: 3,
                      right: 2,
                      child: Text(
                        DateConverter.localDateToIsoStringAMPM(
                            DateTime.parse(transactions!.createdAt!)),
                        style: rubikRegular.copyWith(
                          fontSize: Dimensions.fontSizeExtraSmall,
                          color: ColorResources.getHintColor(),
                        ),
                      ),
                    )
                  : Positioned(
                      bottom: 3,
                      left: 2,
                      child: Text(
                        DateConverter.localDateToIsoStringAMPM(
                            DateTime.parse(transactions!.createdAt!)),
                        style: rubikRegular.copyWith(
                          fontSize: Dimensions.fontSizeExtraSmall,
                          color: ColorResources.getHintColor(),
                        ),
                      ),
                    ),
            ],
          ),
        ));
  }
}
