import 'package:bloc/bloc.dart';
import 'package:nososova/models/node_info.dart';
import 'package:nososova/models/seed.dart';
import 'package:nososova/repositories/local_repository.dart';
import 'package:nososova/repositories/server_repository.dart';
import 'package:nososova/repositories/shared_repository.dart';
import 'package:nososova/services/shared_service.dart';

import '../utils/network/network_const.dart';

abstract class AppDataEvent {}

class StartNode extends AppDataEvent {}

class FetchNodesList extends AppDataEvent {
  FetchNodesList();
}

class ReconnectSeed extends AppDataEvent {
  ReconnectSeed();
}

class AppDataState {
  final NodeInfo nodeInfo;
  final Seed seedActive;
  final int statusConnected;
  final List<Seed> nodesList;

  AppDataState({
    this.statusConnected = StatusConnectNodes.statusLoading,
    NodeInfo? nodeInfo,
    Seed? seedActive,
    List<Seed>? nodesList,
  })  : nodeInfo = nodeInfo ?? NodeInfo(seed: Seed()),
        seedActive = seedActive ?? Seed(),
        nodesList = nodesList ?? List.empty();

  AppDataState copyWith({
    NodeInfo? nodeInfo,
    Seed? seedActive,
    int? statusConnected,
    List<Seed>? nodesList,
  }) {
    return AppDataState(
      nodeInfo: nodeInfo ?? this.nodeInfo,
      seedActive: seedActive ?? this.seedActive,
      statusConnected: statusConnected ?? this.statusConnected,
      nodesList: nodesList ?? this.nodesList,
    );
  }
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

    on<FetchNodesList>((event, emit) async {
      final nodesList = await _serverRepository.fetchNodeList(state.seedActive);
      emit(state.copyWith(nodesList: nodesList));
    });

    on<ReconnectSeed>((event, emit) async {
     emit(state.copyWith(statusConnected: StatusConnectNodes.statusLoading));
      Seed seed = await _serverRepository.testNode(state.seedActive);
      if (!seed.online) {
        emit( state.copyWith(statusConnected: StatusConnectNodes.statusError));
      } else {
        final nodeInfo = await _serverRepository.fetchNode(seed);
        _sharedRepository.saveLastBlock(nodeInfo.lastblock);
        emit(state.copyWith(
            seedActive: seed,
            nodeInfo: nodeInfo,
            statusConnected: StatusConnectNodes.statusConnected));
      }
    });
  }

  /// Ініціалізація підключен до вузлів
  //додати збереженя останього блоку
  void _init() async {
    final sharedService = SharedService();
    await sharedService.init();
    _sharedRepository = SharedRepository(sharedService);
    String? lastSeed = await _sharedRepository.loadLastSeed();
    int? lastBlock = await _sharedRepository.loadLastBlock();
    if (lastSeed != null) {
      //start connect to last seed
      _startNode(false, Seed().tokenizer(lastSeed), lastBlock);
    } else {
      //start connect to testSeed
      _startNode(true, Seed(), lastBlock);
    }
  }

  /// Підключення до вибраної ноди
  void _startNode(bool testSeed, Seed seedActive, int? lastBlock) async {
    Seed seed;
    if (testSeed) {
      seed = await _serverRepository.listenNodes();
      _sharedRepository.saveLastSeed(seed.toTokenizer());
    } else {
      seed = await _serverRepository.testNode(seedActive);
    }
    if (!seed.online) {
      emit(AppDataState(
          seedActive: seed,
          nodeInfo: state.nodeInfo.copyWith(lastblock: lastBlock),
          statusConnected: StatusConnectNodes.statusError));
    } else {
      final nodeInfo = await _serverRepository.fetchNode(seed);
      _sharedRepository.saveLastBlock(nodeInfo.lastblock);
      emit(AppDataState(
          seedActive: seed,
          nodeInfo: nodeInfo,
          statusConnected: StatusConnectNodes.statusConnected));
    }
  //  print(seedActive.toTokenizer());
  //  print(seed.toTokenizer());
  }
}
