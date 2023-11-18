import 'package:nososova/services/livecoinwatch_service.dart';

import '../models/currency_model.dart';

class LiveCoinWatchRepository {
  final LiveCoinWatchService _liveCoinWatchService;

  LiveCoinWatchRepository(this._liveCoinWatchService);

  Future<CurrencyModel?> fetchMarket() {
    return _liveCoinWatchService.fetchMarketInfo();
  }
}
