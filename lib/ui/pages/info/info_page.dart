import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nososova/models/app/info_coin.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../blocs/app_data_bloc.dart';
import '../../../models/currency_model.dart';
import '../../theme/decoration/other_gradient_decoration.dart';
import '../../theme/style/text_style.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  InfoPageState createState() => InfoPageState();
}

class InfoPageState extends State<InfoPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ZoomPanBehavior _zoomPanBehavior;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enablePanning: true,
      zoomMode: ZoomMode.x,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppDataBloc, AppDataState>(builder: (context, state) {
      var infoCoin = state.infoCoin;
      var lastHistory =
          infoCoin.currencyModel?.getLastHistoryItem().rate ?? 0.0000000;
      var firstHistory =
          infoCoin.currencyModel?.history.first.rate ?? 0.0000000;
      return Scaffold(
          appBar: null,
          body: Container(
            decoration: const OtherGradientDecoration(),
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 5),
                                      Text(
                                        "Noso Price",
                                        style: AppTextStyles.itemStyle
                                            .copyWith(fontSize: 20),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            infoCoin.currencyModel
                                                    ?.getLastHistoryItem()
                                                    .rate
                                                    .toStringAsFixed(7) ??
                                                "0.0000000",
                                            style: AppTextStyles.titleMin
                                                .copyWith(
                                                    fontSize: 36,
                                                    color: Colors.black),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "USDT",
                                            style: AppTextStyles.titleMin
                                                .copyWith(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      difference(lastHistory, firstHistory),
                                      const SizedBox(height: 20),
                                      SfCartesianChart(
                                          zoomPanBehavior: _zoomPanBehavior,
                                          primaryXAxis: CategoryAxis(
                                            labelRotation: 45,
                                          desiredIntervals: 5),
                                          primaryYAxis: NumericAxis(
                                            desiredIntervals: 5,
                                          ),
                                          series: <LineSeries<HistoryItem,
                                              String>>[
                                            LineSeries<HistoryItem, String>(
                                              dataSource: infoCoin
                                                      .currencyModel?.history ??
                                                  [],
                                              xValueMapper:
                                                  (HistoryItem hist, _) => DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(hist.date).toLocal()),
                                              yValueMapper:
                                                  (HistoryItem hist, _) =>
                                                      hist.rate,
                                            )
                                          ]),
                                      const SizedBox(height: 20),
                                    ])),
                            TabBar(
                              controller: _tabController,
                              isScrollable: true,
                              indicatorColor:
                                  const Color(0xFF2B2F4F).withOpacity(0.4),
                              indicatorPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              tabs: [
                                Tab(
                                  child: Text(
                                    "Information",
                                    style: AppTextStyles.itemStyle.copyWith(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    "Marketplace",
                                    style: AppTextStyles.itemStyle.copyWith(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                                child: TabBarView(
                              controller: _tabController,
                              children: [
                                information(infoCoin),
                                Container(
                                  color: Colors.green,
                                  child: const Text('Page 2'),
                                ),
                              ],
                            )),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ));
    });
  }

  difference(double first, double last) {
    var diff = (((first - last) / last) * 100);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "${diff < 0 ? "" : "+"}${diff.toStringAsFixed(2)}",
          style: AppTextStyles.titleMin.copyWith(
              color: diff == 0
                  ? Colors.black
                  : diff < 0
                      ? Colors.red
                      : Colors.green,
              fontSize: 20),
        ),
      ],
    );
  }

  information(InfoCoin infoCoin) {
    var coinLocked = infoCoin.coinLock;
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        itemInfo("Blocks Remaining", infoCoin.blockRemaining.toString()),
        itemInfo(
            "Days until Next Halving", infoCoin.nextHalvingDays.toString()),
        itemInfo("Number of mined coins",
            NumberFormat.compact().format(infoCoin.cSupply),
            twoValue: "21M"),
        itemInfo("Coins Locked", NumberFormat.compact().format(coinLocked)),
        itemInfo(
            "Noso Marketcap",
            NumberFormat.compact().format(infoCoin.cSupply *
                infoCoin.currencyModel!.getLastHistoryItem().rate)),
        itemInfo(
            "Total Value Locked",
            NumberFormat.compact().format(infoCoin.coinLock *
                infoCoin.currencyModel!.getLastHistoryItem().rate)),
        Divider(
          color: Colors.grey.withOpacity(0.5),
        )
      ],
    ));
  }

  itemInfo(String nameItem, String value, {String twoValue = ""}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            nameItem,
            style: AppTextStyles.itemStyle
                .copyWith(color: Colors.black.withOpacity(0.5), fontSize: 18),
          ),
          const SizedBox(height: 5),
          Row(children: [
            Text(
              value,
              style: AppTextStyles.walletAddress
                  .copyWith(color: Colors.black, fontSize: 18),
            ),
            if (twoValue.isNotEmpty)
              Text(
                " / $twoValue",
                style: AppTextStyles.walletAddress
                    .copyWith(color: Colors.black, fontSize: 18),
              )
          ])
        ],
      ),
    );
  }
}

class SalesData {
  final String month;
  final double sales;

  SalesData(this.month, this.sales);
}
