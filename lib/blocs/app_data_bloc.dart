import 'package:bloc/bloc.dart';
import 'package:nososova/repositories/local_repository.dart';
import 'package:nososova/repositories/server_repository.dart';
import 'package:nososova/repositories/shared_repository.dart';
import 'package:nososova/services/shared_service.dart';
import 'package:nososova/utils/network/models/node_info.dart';
import 'package:nososova/utils/network/models/seed.dart';

abstract class AppDataEvent {}

class StartNode extends AppDataEvent {}

class AppDataState {
  final NodeInfo nodeInfo;
  final Seed seedActive;

  AppDataState({NodeInfo? nodeInfo, Seed? seedActive})
      : nodeInfo = nodeInfo ?? NodeInfo(seed: Seed()),
        seedActive = seedActive ?? Seed();
}

class AppDataBloc extends Bloc<AppDataEvent, AppDataState> {
  final ServerRepository _serverRepository;
  final LocalRepository _localRepository;
  late SharedRepository _sharedRepository;
  AppDataBloc({
    required ServerRepository serverRepository,
    required LocalRepository localRepository,
  })  : _serverRepository = serverRepository,
        _localRepository = localRepository,
        super(AppDataState()) {
    _init();
  }

  void _init() async {
    final sharedService = SharedService();
    await sharedService.init();
    _sharedRepository = SharedRepository(sharedService);
    String? lastSeed = await _sharedRepository.loadLastSeed();
    if (lastSeed != null) {
      List<String> seedPart = lastSeed.split(":");
      _startNode(false, Seed(ip: seedPart[0], port: int.parse(seedPart[1])));
    } else {
      _startNode(true, Seed());
    }
  }

  void _startNode(bool testSeed, Seed seedActive) async {
    Seed seed;
    if (testSeed) {
      seed = await _serverRepository.listenNodes();
      _sharedRepository.saveLastSeed("${seed.ip}:${seed.port}");
    } else {
      seed = await _serverRepository.testNode(seedActive);
    }
    final nodeInfo = await _serverRepository.fetchNode(seed);
    _sharedRepository.saveLastBlock(nodeInfo.lastblock.toString());
    emit(AppDataState(seedActive: seed, nodeInfo: nodeInfo));
  }
}
