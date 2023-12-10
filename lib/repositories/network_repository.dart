import 'package:nososova/models/app/responses/response_node.dart';
import 'package:nososova/models/seed.dart';
import 'package:nososova/services/explorer_stats_service.dart';
import 'package:nososova/services/node_service.dart';

import '../models/app/responses/response_api.dart';
import '../services/livecoinwatch_service.dart';

class NetworkRepository {
  final NodeService _nodeService;
  final LiveCoinWatchService _liveCoinWatchService;
  final ExplorerStatsService _explorerStatsService;

  NetworkRepository(this._nodeService, this._liveCoinWatchService, this._explorerStatsService);


  /// Node Service
  Future<ResponseNode> listenNodes() {
    return _nodeService.testsListDefaultSeeds();
  }

  Future<ResponseNode> testNode(Seed seed) {
    return _nodeService.testLastSeed(seed);
  }

  Future<ResponseNode<List<int>>> fetchNode(String command, Seed seed) {
    return _nodeService.fetchNode(command, seed);
  }


  /// Live Coin Watch Service
  /// https://livecoinwatch.github.io/lcw-api-docs/

  Future<ResponseApi> fetchHistoryCoin() {
    return _liveCoinWatchService.fetchHistory();
  }

  Future<ResponseApi> fetchMinimalInfo() {
    return _liveCoinWatchService.fetchMinimalInfo();
  }


  /// Api Explorer Service
  /// https://api.nosocoin.com/docs/

  Future<ResponseApi> fetchBlockInfo(int blockHeight) {
    return _explorerStatsService.fetchBlockMNS(blockHeight);
  }

  Future<ResponseApi> fetchHistoryTransactions(String hashAddress) {
    return _explorerStatsService.fetchHistoryTransactions(hashAddress);
  }
  Future<ResponseApi> fetchHistoryPrice() {
    return _explorerStatsService.fetchHistoryPrice();
  }

}
