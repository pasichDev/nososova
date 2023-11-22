import 'package:nososova/models/apiLiveCoinWatch/minimal_info_coin.dart';

import '../apiLiveCoinWatch/full_info_coin.dart';

class InfoCoin {
  int blockRemaining = 0;
  int nextHalvingDays = 0;
  int cSupply = 0;
  int coinLock = 0;
  FullInfoCoin? historyCoin;
  MinimalInfoCoin? minimalInfo;
  double marketcap = 0;
  double tvl = 0;
  int activeNode = 0;
  double tvr = 0;
  double nbr = 0;
  double nr24 = 0;
  double nr7 = 0;
  double nr30 = 0;

  InfoCoin({
    this.blockRemaining = 0,
    this.nextHalvingDays = 0,
    this.cSupply = 0,
    this.historyCoin,
    this.minimalInfo,
    this.coinLock = 0,
    this.marketcap = 0,
    this.tvl = 0,
    this.activeNode = 0,
    this.tvr = 0,
    this.nbr = 0,
    this.nr24 = 0,
    this.nr7 = 0,
    this.nr30 = 0,
  });

  InfoCoin copyWith({
    int? blockRemaining,
    int? nextHalvingDays,
    int? cSupply,
    FullInfoCoin? historyCoin,
    MinimalInfoCoin? minimalInfo,
    int? coinLock,
    double? marketcap,
    double? tvl,
    int? activeNode,
    double? tvr,
    double? nbr,
    double? nr24,
    double? nr7,
    double? nr30,
  }) {
    return InfoCoin(
      blockRemaining: blockRemaining ?? this.blockRemaining,
      nextHalvingDays: nextHalvingDays ?? this.nextHalvingDays,
      cSupply: cSupply ?? this.cSupply,
      historyCoin: historyCoin ?? this.historyCoin,
      minimalInfo: minimalInfo ?? this.minimalInfo,
      coinLock: coinLock ?? this.coinLock,
      marketcap: marketcap ?? this.marketcap,
      tvl: tvl ?? this.tvl,
      activeNode: activeNode ?? this.activeNode,
      tvr: tvr ?? this.tvr,
      nbr: nbr ?? this.nbr,
      nr24: nr24 ?? this.nr24,
      nr7: nr7 ?? this.nr7,
      nr30: nr30 ?? this.nr30,
    );
  }
}
