
import 'package:nososova/models/node.dart';
import 'package:nososova/models/response_node.dart';
import 'package:nososova/models/seed.dart';
import 'package:nososova/services/server_service.dart';

class ServerRepository {
  final ServerService _serverService;

  ServerRepository(this._serverService);

  Future<ResponseNode> listenNodes() {
    return _serverService.testsListDefaultSeeds();
  }
  Future<ResponseNode> testNode(Seed seed) {
    return _serverService.testLastSeed(seed);
  }
  Future<ResponseNode<List<int>>> fetchNode(String command, Seed seed) {
    return _serverService.fetchNode(command, seed);
  }

}
