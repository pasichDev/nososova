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
  final ApiStatus apiPriceStatus;

  CoinInfoState({
    InfoCoin? infoCoin,
    ApiStatus? apiStatus,
    ApiStatus? apiPriceStatus,
  })  : infoCoin = infoCoin ?? InfoCoin(),
        apiStatus = apiStatus ?? ApiStatus.loading,
        apiPriceStatus = apiPriceStatus ?? ApiStatus.loading;

  CoinInfoState copyWith({
    InfoCoin? infoCoin,
    ApiStatus? apiStatus,
    ApiStatus? apiPriceStatus,
  }) {
    return CoinInfoState(
      infoCoin: infoCoin ?? this.infoCoin,
      apiStatus: apiStatus ?? this.apiStatus,
      apiPriceStatus: apiPriceStatus ?? this.apiPriceStatus,
    );
  }
}

class CoinInfoBloc extends Bloc<CoinInfoEvent, CoinInfoState> {
  final AppDataBloc appDataBloc;
  final Repositories _repositories;
  Timer? _timerHistory;
  Timer? _timerMinimalInfo;

  CoinInfoBloc({
    required Repositories repositories,
    required this.appDataBloc,
  })  : _repositories = repositories,
        super(CoinInfoState()) {
    init();
    on<InitFetchHistory>(_initHistoryPrice);
    on<CancelFetchHistory>(_cancelHistory);
  }

  init() async {
    await initMinimalInfo();

  }

  _cancelHistory(event, emit){
    _timerHistory?.cancel();
    emit(state.copyWith(apiStatus: ApiStatus.loading));
  }

  _initHistoryPrice(event, emit) {
    fetchHistory();
    _timerHistory = Timer.periodic(const Duration(minutes: 5), (timer) {
      fetchHistory();
    });
  }

  initMinimalInfo() {
    _timerMinimalInfo = Timer.periodic(const Duration(seconds: 5), (timer) {
      fetchMinimalInfo();
    });
  }

  /// TODO Метод для справжньої кількості монет
  fetchMinimalInfo() async {
    var response =
        await _repositories.networkRepository.fetchMinimalInfo();
    var halving = getHalvingTimer(appDataBloc.state.node.lastblock);

    if (response.errors == null) {
      MinimalInfoCoin value = response.value;
      var activeNode = appDataBloc.state.statsInfoCoin.totalNodesPeople;
      var coinLock = activeNode * 10500;
      var cSupply = appDataBloc.state.statsInfoCoin.totalCoin;
      double blockReward = appDataBloc.state.statsInfoCoin.blockInfo.total;
      var nodeReward = appDataBloc.state.statsInfoCoin.blockInfo.reward;
      emit(state.copyWith(
        apiPriceStatus: ApiStatus.connected,
          infoCoin: state.infoCoin.copyWith(
              blockRemaining: halving.blocks,
              nextHalvingDays: halving.days,
              cSupply: cSupply,
              activeNode: activeNode,
              coinLock: coinLock,
              minimalInfo: response.value,
              marketcap: cSupply * value.rate,
              tvr: blockReward,
              nbr: nodeReward,
              nr7: nodeReward * 1008,
              nr24: nodeReward * 144,
              nr30: nodeReward * 4320,
              tvl: coinLock * value.rate)));
    } else {
      emit(state.copyWith(apiPriceStatus: ApiStatus.error));
    }
  }

  fetchHistory() async {
    var response =
        await _repositories.networkRepository.fetchHistoryPrice();

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
    _timerHistory?.cancel();
    _timerMinimalInfo?.cancel();
    return super.close();
  }
}
