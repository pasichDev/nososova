import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:nososova/models/node.dart';
import 'package:nososova/models/response_node.dart';
import 'package:nososova/models/seed.dart';
import 'package:nososova/repositories/local_repository.dart';
import 'package:nososova/repositories/server_repository.dart';
import 'package:nososova/repositories/shared_repository.dart';
import 'package:nososova/services/shared_service.dart';

import '../utils/network/network_const.dart';
import '../utils/noso/parse.dart';

abstract class AppDataEvent {}

class InitialConnect extends AppDataEvent {}

class FetchNodesList extends AppDataEvent {
  FetchNodesList();
}

class ReconnectSeed extends AppDataEvent {
  ReconnectSeed();
}

class AppDataState {
  final Node node;
  final Seed seedActive;
  final StatusConnectNodes statusConnected;
  final ConnectivityResult connectivityResult;

  AppDataState({
    this.statusConnected = StatusConnectNodes.statusLoading,
    this.connectivityResult = ConnectivityResult.none,
    Node? node,
    Seed? seedActive,
  })  : node = node ?? Node(seed: Seed()),
        seedActive = seedActive ?? Seed();

  AppDataState copyWith({
    Node? node,
    Seed? seedActive,
    StatusConnectNodes? statusConnected,
    ConnectivityResult? connectivityResult,
  }) {
    return AppDataState(
      node: node ?? this.node,
      seedActive: seedActive ?? this.seedActive,
      statusConnected: statusConnected ?? this.statusConnected,
      connectivityResult: connectivityResult ?? this.connectivityResult,
    );
  }
}

class AppDataBloc extends Bloc<AppDataEvent, AppDataState> {
  late String? _lastSeed;
  late String? _nodesList;
  late int? _lastBlock;
  late int? _delaySync;
  late Timer? _timerDelaySync;

  final ServerRepository _serverRepository;
  final LocalRepository _localRepository;
  late SharedRepository _sharedRepository;

  // TODO: Реалізація та виправлення моніторнингу мережі. Якщо мережі немає то блокувати запити та морозити всі стани
  AppDataBloc({
    required ServerRepository serverRepository,
    required LocalRepository localRepository,
  })  : _serverRepository = serverRepository,
        _localRepository = localRepository,
        super(AppDataState()) {
    Connectivity().onConnectivityChanged.listen((result) {});
    on<ReconnectSeed>(_reconnectNode);
    on<InitialConnect>(_init);
  }

  // TODO: Додати пропис останього блоку в node
  Future<void> _init(AppDataEvent e, Emitter emit) async {
    final sharedService = SharedService();
    await sharedService.init();
    _sharedRepository = SharedRepository(sharedService);
    _lastSeed = await _sharedRepository.loadLastSeed();
    _nodesList = await _sharedRepository.loadNodesList();
    _lastBlock = await _sharedRepository.loadLastBlock();
    _delaySync = await _sharedRepository.loadDelaySync();
    _delaySync ??= 15;

    if (_lastSeed != null) {
      _selectNode(InitialNodeAlgh.connectLastNode);
    } else if (_nodesList != null) {
      _selectNode(InitialNodeAlgh.listenUserNodes);
    } else {
      _selectNode(InitialNodeAlgh.listenDefaultNodes);
    }
  }

  Future<void> _reconnectNode(AppDataEvent e, Emitter emit) async {
    emit(state.copyWith(statusConnected: StatusConnectNodes.statusLoading));
    await _selectNode(InitialNodeAlgh.listenUserNodes);
  }

  /// Підключення та вибір ноди
  Future<void> _selectNode(InitialNodeAlgh initNodeAlgh) async {
    ResponseNode response;

    switch (initNodeAlgh) {
      case InitialNodeAlgh.connectLastNode:
        {
          response =
              await _serverRepository.testNode(Seed().tokenizer(_lastSeed));
          if (response.errors != null) {
            await _selectNode(InitialNodeAlgh.listenDefaultNodes);
            return;
          }
        }
        break;
      case InitialNodeAlgh.listenUserNodes:
        {
          var seed = Seed().tokenizer(NosoParse.getRandomNode(_nodesList));
          response = await _serverRepository.testNode(seed);
          if (response.errors == null) {
            _sharedRepository.saveLastSeed(response.seed.toTokenizer());
          }
        }

        break;
      default:
        {
          response = await _serverRepository.listenNodes();
          if (response.errors == null) {
            _sharedRepository.saveLastSeed(response.seed.toTokenizer());
          } else {
            await _selectNode(InitialNodeAlgh.listenUserNodes);
            return;
          }
        }
        break;
    }

    if (response.errors != null) {
      emit(state.copyWith(
          node: state.node.copyWith(lastblock: _lastBlock),
          statusConnected: StatusConnectNodes.statusError));
    } else {
      _syncApp(response.seed);
      _timerDelaySync = Timer.periodic(Duration(seconds: _delaySync!), (timer) {
        _syncApp(response.seed);
      });
    }
  }

  Future<void> _syncApp(Seed seed) async {
    ResponseNode<List<int>> responseNodeInfo =
        await _fetchNode(NetworkRequest.nodeStatus, seed);
    ResponseNode<List<int>> responseNodeList =
        await _fetchNode(NetworkRequest.nodeList, seed);

    if (responseNodeList.value != null) {
      _sharedRepository.saveNodesList(
          NosoParse.parseMNString(responseNodeList.value as List<int>));
    }
    if (responseNodeInfo.value != null) {
      emit(state.copyWith(
          seedActive: seed,
          node: NosoParse.parseResponseNode(
              responseNodeInfo.value as List<int>, state.seedActive),
          statusConnected: StatusConnectNodes.statusConnected));
    }

   // ResponseNode<List<int>> respd = await _fetchNode("NSLBALANCE N44pzj8pJ6M63fmJT22QuXbqN3vSiDG\n", seed);

    //print( String.fromCharCodes(respd.value as Iterable<int>));
    //print(respd.errors);

  }

  Future<ResponseNode<List<int>>> _fetchNode(String command, Seed? seed) async {
    seed ??= state.seedActive;
    if (state.statusConnected == StatusConnectNodes.statusError) {
      return ResponseNode(errors: "You are not connected to nodes.");
    }
    return await _serverRepository.fetchNode(command, seed);
  }

  @override
  Future<void> close() {
    _stopTimer();
    return super.close();
  }

  void _stopTimer() {
    _timerDelaySync?.cancel();
  }
}
