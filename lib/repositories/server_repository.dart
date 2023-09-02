import 'package:nososova/network/models/node_info.dart';
import 'package:nososova/network/models/seed.dart';
import 'package:nososova/services/server_service.dart';

class ServerRepository {
  final ServerService _serverService;

  ServerRepository(this._serverService);

  Future<Seed> listenNodes(){
    return _serverService.checkSeed();
  }
  Future<NodeInfo> fetchNode(Seed seedActive){
    return _serverService.fetchNodeInfo(seedActive);
  }
}
