
import 'package:nososova/models/node_info.dart';
import 'package:nososova/models/seed.dart';
import 'package:nososova/services/server_service.dart';

class ServerRepository {
  final ServerService _serverService;

  ServerRepository(this._serverService);

  Future<Seed> listenNodes() {
    return _serverService.checkSeeds();
  }

  Future<NodeInfo> fetchNode(Seed seedActive) {
    return _serverService.fetchNodeInfo(seedActive);
  }

  Future<Seed> testNode(Seed seed) {
    return _serverService.testConnectionNode(seed);
  }
}
