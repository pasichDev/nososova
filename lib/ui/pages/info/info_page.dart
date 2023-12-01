import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nososova/models/app/info_coin.dart';
import 'package:nososova/utils/status_api.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../blocs/coin_info_bloc.dart';
import '../../../blocs/events/coin_info_events.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/apiLiveCoinWatch/full_info_coin.dart';
import '../../components/info_item.dart';
import '../../components/loading.dart';
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
  late CoinInfoBloc coinInfoBloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enablePanning: true,
      zoomMode: ZoomMode.x,
    );
    coinInfoBloc = BlocProvider.of<CoinInfoBloc>(context);
    coinInfoBloc.add(InitFetchHistory());
  }

  @override
  void dispose() {
    coinInfoBloc.add(CancelFetchHistory());
    super.dispose();
  }

  /// TODO ADD ERROR WIDGET
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoinInfoBloc, CoinInfoState>(builder: (context, state) {
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
                        child: body(state)),
                  ),
                ),
              ],
            ),
          ));
    });
  }

  body(CoinInfoState state) {
    var infoCoin = state.infoCoin;
    var firstHistory = infoCoin.historyCoin?.history.first.rate ?? 0.0000000;

    if (state.apiStatus == ApiStatus.loading) {
      return LoadingWidget();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 5),
              Text(
                AppLocalizations.of(context)!.nosoPrice,
                style: AppTextStyles.itemStyle.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    infoCoin.minimalInfo?.rate.toStringAsFixed(8) ??
                        "0.0000000",
                    style: AppTextStyles.titleMin
                        .copyWith(fontSize: 36, color: Colors.black),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "USDT",
                    style: AppTextStyles.titleMin.copyWith(color: Colors.black),
                  ),
                ],
              ),
              difference(infoCoin.minimalInfo?.rate ?? 0, firstHistory),
              const SizedBox(height: 20),
              SfCartesianChart(
                  zoomPanBehavior: _zoomPanBehavior,
                  primaryXAxis: CategoryAxis(
                      labelRotation: 45,
                      desiredIntervals: 5,
                      majorGridLines: const MajorGridLines(width: 0)),
                  primaryYAxis: NumericAxis(
                    majorGridLines: const MajorGridLines(width: 0),
                    visibleMinimum:
                        infoCoin.historyCoin!.history.first.rate / 1.4,
                  ),
                  series: <LineSeries<HistoryItem, String>>[
                    LineSeries<HistoryItem, String>(
                      dataSource: infoCoin.historyCoin?.history ?? [],
                      xValueMapper: (HistoryItem hist, _) => DateFormat('HH:mm')
                          .format(DateTime.fromMillisecondsSinceEpoch(hist.date)
                              .toLocal()),
                      yValueMapper: (HistoryItem hist, _) => hist.rate,
                    )
                  ]),
              const SizedBox(height: 10),
            ])),
        TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: const Color(0xFF2B2F4F).withOpacity(0.4),
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
          tabs: [
            Tab(
              child: Text(
                AppLocalizations.of(context)!.information,
                style: AppTextStyles.itemStyle
                    .copyWith(color: Colors.black, fontSize: 20),
              ),
            ),
            Tab(
              child: Text(
                AppLocalizations.of(context)!.masternodes,
                style: AppTextStyles.itemStyle
                    .copyWith(color: Colors.black, fontSize: 20),
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
            masterNodes(infoCoin, 0),
          ],
        )),
      ],
    );
  }

  difference(double first, double last) {
    var diff = (((first - last) / last) * 100);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "${diff < 0 ? "" : "+"}${diff.toStringAsFixed(2)}%",
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
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InfoItem().itemInfo(AppLocalizations.of(context)!.blocksRemaining,
            infoCoin.blockRemaining.toString()),
        InfoItem().itemInfo(AppLocalizations.of(context)!.daysUntilNextHalving,
            infoCoin.nextHalvingDays.toString()),
        InfoItem().itemInfo(AppLocalizations.of(context)!.numberOfMinedCoins,
            NumberFormat.compact().format(infoCoin.cSupply),
            twoValue: "21M"),
        InfoItem().itemInfo(AppLocalizations.of(context)!.coinsLocked,
            NumberFormat.compact().format(infoCoin.coinLock)),
        InfoItem().itemInfo(AppLocalizations.of(context)!.marketcap,
            "\$${NumberFormat.compact().format(infoCoin.marketcap)}"),
        InfoItem().itemInfo(AppLocalizations.of(context)!.tvl,
            "\$${NumberFormat.compact().format(infoCoin.tvl)}"),
        InfoItem().itemInfo(AppLocalizations.of(context)!.maxPriceStory,
            "${infoCoin.minimalInfo?.allTimeHighUSD.toStringAsFixed(8) ?? "0.0000000"} NOSO")
      ],
    ));
  }

  masterNodes(InfoCoin infoCoin, int blockHeight) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InfoItem().itemInfo(AppLocalizations.of(context)!.activeNodes,
            infoCoin.activeNode.toString()),
        InfoItem().itemInfo(AppLocalizations.of(context)!.tmr,
            "${infoCoin.tvr.toStringAsFixed(5)} NOSO"),
        InfoItem().itemInfo(AppLocalizations.of(context)!.nbr,
            "${infoCoin.nbr.toStringAsFixed(8)} NOSO"),
        InfoItem().itemInfo(AppLocalizations.of(context)!.nr24,
            "${infoCoin.nr24.toStringAsFixed(8)} NOSO"),
        InfoItem().itemInfo(AppLocalizations.of(context)!.nr7,
            "${infoCoin.nr7.toStringAsFixed(8)} NOSO"),
        InfoItem().itemInfo(AppLocalizations.of(context)!.nr30,
            "${infoCoin.nr30.toStringAsFixed(8)} NOSO")
      ],
    ));
  }
}
