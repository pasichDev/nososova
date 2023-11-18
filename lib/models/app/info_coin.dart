import '../currency_model.dart';

class InfoCoin {
  int blockRemaining = 0;
  int nextHalvingDays = 0;
  int cSupply = 0;
  int coinLock = 0;
  CurrencyModel? currencyModel;

  InfoCoin({
    this.blockRemaining = 0,
    this.nextHalvingDays = 0,
    this.cSupply = 0,
    this.currencyModel,
    this.coinLock = 0,
  });

  InfoCoin copyWith({
    int? blockRemaining,
    int? nextHalvingDays,
    int? cSupply,
    CurrencyModel? currencyModel,
    int? coinLock,
  }) {
    return InfoCoin(
      blockRemaining: blockRemaining ?? this.blockRemaining,
      nextHalvingDays: nextHalvingDays ?? this.nextHalvingDays,
      cSupply: cSupply ?? this.cSupply,
      currencyModel: currencyModel ?? this.currencyModel,
      coinLock: coinLock ?? this.coinLock,
    );
  }
}
