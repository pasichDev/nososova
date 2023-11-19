import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:nososova/blocs/app_data_bloc.dart';
import 'package:nososova/models/apiLiveCoinWatch/minimal_info_coin.dart';
import 'package:nososova/repositories/repositories.dart';

import '../models/app/halving.dart';
import '../models/app/info_coin.dart';
import '../utils/status_api.dart';
import 'events/coin_info_events.dart';

class CoinInfoState {
  final InfoCoin infoCoin;
  final ApiStatus apiStatus;

  CoinInfoState({
    InfoCoin? infoCoin,
    ApiStatus? apiStatus,
  })  : infoCoin = infoCoin ?? InfoCoin(),
        apiStatus = apiStatus ?? ApiStatus.loading;

  CoinInfoState copyWith({
    InfoCoin? infoCoin,
    ApiStatus? apiStatus,
  }) {
    return CoinInfoState(
      infoCoin: infoCoin ?? this.infoCoin,
      apiStatus: apiStatus ?? this.apiStatus,
    );
  }
}

class CoinInfoBloc extends Bloc<CoinInfoEvent, CoinInfoState> {
  final AppDataBloc appDataBloc;
  final Repositories _repositories;
  Timer? _timerFullInfo;
  Timer? _timerMinimalInfo;

  CoinInfoBloc({
    required Repositories repositories,
    required this.appDataBloc,
  })  : _repositories = repositories,
        super(CoinInfoState()) {
    init();
  }

  init() async {
    await initMinimalInfo();
    await initHistoryPrice();
  }

  initHistoryPrice() {
    fetchHistory();
    _timerFullInfo = Timer.periodic(const Duration(minutes: 5), (timer) {
      fetchHistory();
    });
  }

  initMinimalInfo() {
    fetchMinimalInfo();
    _timerMinimalInfo = Timer.periodic(const Duration(seconds: 10), (timer) {
      fetchMinimalInfo();
    });
  }

  fetchMinimalInfo() async {
    var response =
        await _repositories.liveCoinWatchRepository.fetchMinimalInfo();
    var halving = getHalvingTimer(appDataBloc.state.node.lastblock);

    if (response.errors == null) {
      MinimalInfoCoin value = response.value;
      var coinLock = appDataBloc.state.statsInfoCoin.totalNodesPeople * 10500;
      var cSupply = appDataBloc.state.statsInfoCoin.totalCoin;
      double blockReward = 50;
      var nodeReward = blockReward / appDataBloc.state.statsInfoCoin.totalNodesPeople;
      emit(state.copyWith(
          infoCoin: state.infoCoin.copyWith(
              blockRemaining: halving.blocks,
              nextHalvingDays: halving.days,
              cSupply: cSupply,
              coinLock: coinLock,
              minimalInfo: response.value,
              marketcap: cSupply * value.rate,
              blockHeight: appDataBloc.state.node.lastblock,
              tvr: blockReward,
              nbr: nodeReward,
              nr7: nodeReward * 144,
              nr24: nodeReward * 1008,
              nr30: nodeReward * 4320,
              tvl: coinLock * value.rate)));
    } else {
      emit(state.copyWith(apiStatus: ApiStatus.error));
    }
  }

  fetchHistory() async {
    var response =
        await _repositories.liveCoinWatchRepository.fetchHistoryCoin();

    if (response.errors == null) {
      emit(state.copyWith(
          apiStatus: ApiStatus.connected,
          infoCoin: state.infoCoin.copyWith(historyCoin: response.value)));
    } else {
      emit(state.copyWith(apiStatus: ApiStatus.error));
    }
  }

  Halving getHalvingTimer(int lastBlock) {
    int halvingTimer;
    if (lastBlock < 210000) {
      halvingTimer = 210000 - lastBlock;
    } else if (lastBlock < 420000) {
      halvingTimer = 420000 - lastBlock;
    } else if (lastBlock < 630000) {
      halvingTimer = 630000 - lastBlock;
    } else if (lastBlock < 840000) {
      halvingTimer = 840000 - lastBlock;
    } else if (lastBlock < 1050000) {
      halvingTimer = 1050000 - lastBlock;
    } else if (lastBlock < 1260000) {
      halvingTimer = 1260000 - lastBlock;
    } else if (lastBlock < 1470000) {
      halvingTimer = 1470000 - lastBlock;
    } else if (lastBlock < 1680000) {
      halvingTimer = 1680000 - lastBlock;
    } else if (lastBlock < 1890000) {
      halvingTimer = 1890000 - lastBlock;
    } else if (lastBlock < 2100000) {
      halvingTimer = 2100000 - lastBlock;
    } else {
      halvingTimer = 0;
    }

    int timeRemaining = halvingTimer * 600;
    int timeRemainingDays = ((timeRemaining / (60 * 60 * 24))).ceil();

    return Halving(blocks: halvingTimer, days: timeRemainingDays);
  }

  @override
  Future<void> close() {
    _timerFullInfo?.cancel();
    _timerMinimalInfo?.cancel();
    return super.close();
  }
}
