import 'package:bloc/bloc.dart';
import 'package:nososova/models/node_info.dart';
import 'package:nososova/models/response_node.dart';
import 'package:nososova/models/seed.dart';
import 'package:nososova/repositories/local_repository.dart';
import 'package:nososova/repositories/server_repository.dart';
import 'package:nososova/repositories/shared_repository.dart';
import 'package:nososova/services/shared_service.dart';

import '../utils/network/network_const.dart';
import '../utils/noso/parse.dart';
import 'debug_block.dart';

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


  AppDataState({
    this.statusConnected = StatusConnectNodes.statusLoading,
    NodeInfo? nodeInfo,
    Seed? seedActive,
    List<Seed>? nodesList,
  })  : nodeInfo = nodeInfo ?? NodeInfo(seed: Seed()),
        seedActive = seedActive ?? Seed();


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
    );
  }
}

class AppDataBloc extends Bloc<AppDataEvent, AppDataState> {
  late String? lastSeed;
  late String? nodesList;
  late int? lastBlock;

  final ServerRepository _serverRepository;
  final LocalRepository _localRepository;
  late SharedRepository _sharedRepository;



  AppDataBloc({
    required ServerRepository serverRepository,
    required LocalRepository localRepository,
    required DebugBloc debugBloc,
  })  : _serverRepository = serverRepository,
        _localRepository = localRepository,
        super(AppDataState()) {
    _init();
    on<ReconnectSeed>((event, emit) async {
      emit(state.copyWith(
          statusConnected: StatusConnectNodes.statusLoading));
      _startNode(InitialNodeAlgh.listenUserNodes);
    });
  }

  /// Ініціалізація підключен до вузлів
  //додати збереженя останього блоку
  void _init() async {

    //_debugBloc.add(AddLogString("Initialize connection and synchronization"));
    final sharedService = SharedService();
    await sharedService.init();
    _sharedRepository = SharedRepository(sharedService);
    lastSeed = await _sharedRepository.loadLastSeed();
    nodesList = await _sharedRepository.loadNodesList();
    lastBlock = await _sharedRepository.loadLastBlock();

    if (lastSeed != null) {

    //  _debugBloc.add(AddLogString("Attempting to connect to the last node"));
     // print("start connect to last seed");
      //start connect to last seed
      _startNode(InitialNodeAlgh.connectLastNode);
    } else if (nodesList != null) {
      print("start connect to listNodes");
      _startNode(InitialNodeAlgh.listenUserNodes);
    } else {
      print("start connect to testSeed");
      //start connect to testSeed
      _startNode(InitialNodeAlgh.listenDefaultNodes);
    }
  }

  /// Підключення до вибраної ноди
  void _startNode(int initNodeAlgh) async {
    ResponseNode response;

    switch (initNodeAlgh) {
      case InitialNodeAlgh.connectLastNode:
        {
          response =
              await _serverRepository.testNode(Seed().tokenizer(lastSeed));
          if (response.errors != null) {
            _startNode(InitialNodeAlgh.listenDefaultNodes);
            return;
          }
        }
        break;
      case InitialNodeAlgh.listenUserNodes:
        {
          var seed = Seed().tokenizer(NosoParse.getRandomNode(nodesList));
          print(seed.toTokenizer());
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
            _startNode(InitialNodeAlgh.listenUserNodes);
            return;
          }
        }
        break;
    }

    //якщо є помилки просто зсінимо статус і нічого не завнтажимо
    if (response.errors != null) {
      print("error connecting save");
      emit(state.copyWith(
          nodeInfo: state.nodeInfo.copyWith(lastblock: lastBlock),
          statusConnected: StatusConnectNodes.statusError));
    } else {
      //якщо помилки відстуні продовжимо завнтаження інформації
      print("stat create Connected");

      ResponseNode<List<int>> responseNodeInfo =
          await _fetchNode(NetworkRequest.nodeStatus, response.seed);
      ResponseNode<List<int>> responseNodeList =
          await _fetchNode(NetworkRequest.nodeList, response.seed);

      if (responseNodeList.value != null) {
        _sharedRepository.saveNodesList(
            NosoParse.parseMNString(responseNodeList.value as List<int>));
      }
      if (responseNodeInfo.value != null) {
        emit(state.copyWith(
            seedActive: response.seed,
            nodeInfo: NosoParse.parseResponseNode(
                responseNodeInfo.value as List<int>, state.seedActive),
            statusConnected: StatusConnectNodes.statusConnected));
      }
    }
  }

  Future<ResponseNode<List<int>>> _fetchNode(String command, Seed? seed) async {
    seed ??= state.seedActive;
    if (state.statusConnected == StatusConnectNodes.statusError) {
      return ResponseNode(errors: "You are not connected to nodes.");
    }
    return await _serverRepository.fetchNode(command, seed);
  }
}
