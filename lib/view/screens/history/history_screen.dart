import 'package:six_cash/controller/transaction_history_controller.dart';
import 'package:six_cash/data/model/transaction_model.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';
import 'package:six_cash/view/screens/history/widget/transaction_view_screen.dart';

import '../home/widget/app_bar_base.dart';

class HistoryScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final Transactions? transactions;
  HistoryScreen({Key? key, this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<TransactionHistoryController>().setIndex(0);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const AppBarBase(),
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            await Get.find<TransactionHistoryController>().getTransactionData(1,reload: true);
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            slivers: [
              SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverDelegate(
                      child: Container(
                        color: Theme.of(context).colorScheme.background,
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                        height: 50, alignment: Alignment.centerLeft,
                        child: GetBuilder<TransactionHistoryController>(
                          builder: (historyController){
                            return ListView(
                              shrinkWrap: true,
                                padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                                scrollDirection: Axis.horizontal,
                                children: [
                                  TransactionTypeButton(text: 'all'.tr, index: 0, transactionHistoryList : historyController.transactionList),
                                  const SizedBox(width: 10),

                                  TransactionTypeButton(text: 'send_money'.tr, index: 1, transactionHistoryList: historyController.sendMoneyList),
                                  const SizedBox(width: 10),

                                  TransactionTypeButton(text: 'cash_in'.tr, index: 2, transactionHistoryList: historyController.cashInMoneyList),
                                  const SizedBox(width: 10),

                                  TransactionTypeButton(text: 'add_money'.tr, index: 3, transactionHistoryList: historyController.addMoneyList),
                                  const SizedBox(width: 10),

                                  TransactionTypeButton(text: 'received_money'.tr, index: 4, transactionHistoryList: historyController.receivedMoneyList),
                                  const SizedBox(width: 10),

                                  TransactionTypeButton(text: 'cash_out'.tr, index: 5, transactionHistoryList: historyController.cashOutList),
                                  const SizedBox(width: 10),

                                  TransactionTypeButton(text: 'withdraw'.tr, index: 6, transactionHistoryList: historyController.withdrawList),
                                  const SizedBox(width: 10),

                                  TransactionTypeButton(text: 'payment'.tr, index: 7, transactionHistoryList: historyController.paymentList),
                                  const SizedBox(width: 10),

                                ]);
                          },

                        ),
                      ))),
              SliverToBoxAdapter(
                child: Scrollbar(
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    child: TransactionViewScreen(scrollController: _scrollController,isHome: false),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//
// class PieChartData {
//   const PieChartData(this.color, this.percent);
//
//   final Color color;
//   final double percent;
// }
//
// // our pie chart widget
// class PieChart extends StatelessWidget {
//   PieChart({
//     required this.data,
//     required this.radius,
//     this.strokeWidth = 8,
//     this.child,
//     Key? key,
//   })  : // make sure sum of data is never ovr 100 percent
//         assert(data.fold<double>(0, (sum, data) => sum + data.percent) <= 100),
//         super(key: key);
//
//   final List<PieChartData> data;
//   // radius of chart
//   final double radius;
//   // width of stroke
//   final double strokeWidth;
//   // optional child; can be used for text for example
//   final Widget? child;
//
//   @override
//   Widget build(context) {
//     return CustomPaint(
//       painter: _Painter(strokeWidth, data),
//       size: Size.square(radius),
//       child: SizedBox.square(
//         // calc diameter
//         dimension: radius * 2,
//         child: Center(
//           child: child,
//         ),
//       ),
//     );
//   }
// }
//
// // responsible for painting our chart
// class _PainterData {
//   const _PainterData(this.paint, this.radians);
//
//   final Paint paint;
//   final double radians;
// }
//
// class _Painter extends CustomPainter {
//   _Painter(double strokeWidth, List<PieChartData> data) {
//     // convert chart data to painter data
//     dataList = data
//         .map((e) => _PainterData(
//       Paint()
//         ..color = e.color
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = strokeWidth
//         ..strokeCap = StrokeCap.round,
//       // remove padding from stroke
//       (e.percent - _padding) * _percentInRadians,
//     ))
//         .toList();
//   }
//
//   static const _percentInRadians = 0.062831853071796;
//   // this is the gap between strokes in percent
//   static const _padding = 4;
//   static const _paddingInRadians = _percentInRadians * _padding;
//   // 0 radians is to the right, but since we want to start from the top
//   // we'll use -90 degrees in radians
//   static const _startAngle = -1.570796 + _paddingInRadians / 2;
//
//   late final List<_PainterData> dataList;
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final rect = Offset.zero & size;
//     // keep track of start angle for next stroke
//     double startAngle = _startAngle;
//
//     for (final data in dataList) {
//       final path = Path()..addArc(rect, startAngle, data.radians);
//
//       startAngle += data.radians + _paddingInRadians;
//
//       canvas.drawPath(path, data.paint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return oldDelegate != this;
//   }
// }

class TransactionTypeButton extends StatelessWidget {
  final String text;
  final int index;
  final List<Transactions> transactionHistoryList;

  const TransactionTypeButton({Key? key, required this.text, required this.index, required this.transactionHistoryList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Get.find<TransactionHistoryController>().transactionTypeIndex == index ? Theme.of(context).primaryColor :  Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.radiusSizeLarge),
          border: Border.all(width: .5,color: Theme.of(context).primaryColor)
      ),
      child: CustomInkWell(
        onTap: () => Get.find<TransactionHistoryController>().setIndex(index),
        radius: Dimensions.radiusSizeLarge,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeExtraSmall),
          child: Text(text,
              style: walsheimMedium.copyWith(fontSize: Dimensions.fontSizeDefault,color: Get.find<TransactionHistoryController>().transactionTypeIndex == index
                  ? Theme.of(context).indicatorColor : Theme.of(context).highlightColor)),
        ),
      ),
    );
  }
}


class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  SliverDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 || oldDelegate.minExtent != 50 || child != oldDelegate.child;
  }
}