import 'package:nososova/models/seed.dart';
import 'package:nososova/services/explorer_stats_service.dart';
import 'package:nososova/services/node_service.dart';

import '../models/responses/response_api.dart';
import '../models/responses/response_node.dart';

class NetworkRepository {
  final NodeService _nodeService;
  final ExplorerStatsService _explorerStatsService;

  NetworkRepository(this._nodeService, this._explorerStatsService);

  /// Node Service

  /// DELETE
  Future<ResponseNode<List<Seed>>> listenNodes() {
    return _nodeService.testsListDefaultSeeds();
  }

  /// DELETE
  Future<ResponseNode> testNode(Seed seed) {
    return _nodeService.testLastSeed(seed);
  }

  Future<ResponseNode<List<int>>> fetchNode(String command, Seed seed) {
    return _nodeService.fetchNode(command, seed);
  }

  Future<ResponseNode<List<int>>> getRandomDevNode() {
    return _nodeService.getRandomDevNode();
  }

  /// Api Explorer Service
  /// https://api.nosocoin.com/docs/

  Future<ResponseApi> fetchBlockInfo(int blockHeight) {
    return _explorerStatsService.fetchBlockMNS(blockHeight);
  }

  Future<ResponseApi> fetchHistoryTransactions(String hashAddress) {
    return _explorerStatsService.fetchHistoryTransactions(hashAddress);
  }

  /// TODO DeLETE
  Future<ResponseApi> fetchHistoryPrice() {
    return _explorerStatsService.fetchHistoryPrice();
  }

  Future<ResponseApi> fetchLastBlockInfo() {
    return _explorerStatsService.fetchLastBlockInfo();
  }
}
