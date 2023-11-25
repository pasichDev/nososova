import 'package:nososova/services/livecoinwatch_service.dart';

import '../models/app/responses/response_api.dart';

class LiveCoinWatchRepository {
  final LiveCoinWatchService _liveCoinWatchService;

  LiveCoinWatchRepository(this._liveCoinWatchService);

  Future<ResponseApi> fetchHistoryCoin() {
    return _liveCoinWatchService.fetchHistory();
  }

  Future<ResponseApi> fetchBlockInfo(int blockHeight) {
    return _liveCoinWatchService.fetchBlockMNS(blockHeight);
  }
  Future<ResponseApi> fetchMinimalInfo() {
    return _liveCoinWatchService.fetchMinimalInfo();
  }
}
