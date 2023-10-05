import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:nososova/models/app/app_bloc_config.dart';
import 'package:nososova/models/app/responses/response_node.dart';
import 'package:nososova/models/node.dart';
import 'package:nososova/models/seed.dart';
import 'package:nososova/repositories/local_repository.dart';
import 'package:nososova/repositories/server_repository.dart';
import 'package:nososova/repositories/shared_repository.dart';
import 'package:nososova/services/shared_service.dart';

import '../models/pending_transaction.dart';
import '../utils/const/network_const.dart';
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
  final StatusConnectNodes statusConnected;
  final ConnectivityResult deviceConnectedNetworkStatus;

  //wallet
  final List<PendingTransaction> pendings;

  AppDataState({
    this.statusConnected = StatusConnectNodes.statusLoading,
    this.deviceConnectedNetworkStatus = ConnectivityResult.none,
    Node? node,
    Seed? seedActive,
    List<PendingTransaction>? pendings,
  })  : node = node ?? Node(seed: Seed()),
        pendings = pendings ?? [];

  AppDataState copyWith(
      {Node? node,
      StatusConnectNodes? statusConnected,
      ConnectivityResult? deviceConnectedNetworkStatus,
      List<PendingTransaction>? pendings}) {
    return AppDataState(
      node: node ?? this.node,
      statusConnected: statusConnected ?? this.statusConnected,
      deviceConnectedNetworkStatus:
          deviceConnectedNetworkStatus ?? this.deviceConnectedNetworkStatus,
      pendings: pendings ?? this.pendings,
    );
  }
}

class AppDataBloc extends Bloc<AppDataEvent, AppDataState> {
  AppBlocConfig appBlocConfig = AppBlocConfig();
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
    Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {}
    });
    on<ReconnectSeed>(_reconnectNode);
    on<InitialConnect>(_init);
  }

  // TODO: Додати пропис останього блоку в node
  Future<void> _init(AppDataEvent e, Emitter emit) async {
    final sharedService = SharedService();
    await sharedService.init();
    _sharedRepository = SharedRepository(sharedService);
    await loadConfig();

    if (appBlocConfig.lastSeed != null) {
      _selectNode(InitialNodeAlgh.connectLastNode);
    } else if (appBlocConfig.nodesList != null) {
      _selectNode(InitialNodeAlgh.listenUserNodes);
    } else {
      _selectNode(InitialNodeAlgh.listenDefaultNodes);
    }
  }

  Future<void> _reconnectNode(AppDataEvent e, Emitter emit) async {
    emit(state.copyWith(statusConnected: StatusConnectNodes.statusLoading));
    await _selectNode(InitialNodeAlgh.connectLastNode);
  }

  /// Підключення та вибір ноди
  Future<void> _selectNode(InitialNodeAlgh initNodeAlgh) async {
    ResponseNode response;

    switch (initNodeAlgh) {
      case InitialNodeAlgh.connectLastNode:
        {
          response = await _serverRepository
              .testNode(Seed().tokenizer(appBlocConfig.lastSeed));
          if (response.errors != null) {
            await _selectNode(InitialNodeAlgh.listenDefaultNodes);
            return;
          }
        }
        break;
      case InitialNodeAlgh.listenUserNodes:
        {
          var seed = Seed()
              .tokenizer(NosoParse.getRandomNode(appBlocConfig.nodesList));
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
          node: state.node.copyWith(lastblock: appBlocConfig.lastBlock),
          statusConnected: StatusConnectNodes.statusError));
    } else {
      _syncDataToNode(response.seed);
      _timerDelaySync =
          Timer.periodic(Duration(seconds: appBlocConfig.delaySync), (timer) {
            _syncDataToNode(response.seed);
      });
    }
  }


  Future<void> _syncDataToNode(Seed seed) async {
    ResponseNode<List<int>> responseNodeInfo =
        await _fetchNode(NetworkRequest.nodeStatus, seed);
    ResponseNode<List<int>> responsePendings =
        await _fetchNode(NetworkRequest.pendingsList, seed);

    List<PendingTransaction> pendingsOutput = [];
    final Node nodeOutput = NosoParse.parseResponseNode(
        responseNodeInfo.value, responseNodeInfo.seed);

    if (state.node.lastblock != nodeOutput.lastblock) {
      //Оновлення іншої інфи якщо пербудувався блок
      ResponseNode<List<int>> responseNodeList =
          await _fetchNode(NetworkRequest.nodeList, seed);
      if (responseNodeList.value != null) {
        _sharedRepository.saveNodesList(
            NosoParse.parseMNString(responseNodeList.value));
      }

      // TODO: Ось тут має бути оновленя zipsummary
      // TODO: Потрібно окремо створити сервіс який працює з файлами, тоді ми будемо отримувати байти файла, фантажитемо його в спец директову розпаковуватимемо, і будемо юзавти в walletBloc
    } else {
      //Оновлення статусу ноди якщо немає зміни блоку
      if (responsePendings.errors == null) {
        //pendingsOutput = NosoParse.parsePendings(responsePendings.value);

        // TODO: Ось тут потрібно отримати список як вище і відправити його через подію в walletBloc (SyncBalance)
      }
    }

    if (responseNodeInfo.value != null) {
      emit(state.copyWith(
          node: nodeOutput,
          statusConnected: StatusConnectNodes.statusConnected));
    }
  }

  /// The base method for referencing a request to a node
  Future<ResponseNode<List<int>>> _fetchNode(String command, Seed? seed) async {
    seed ??= state.node.seed;
    if (state.statusConnected == StatusConnectNodes.statusError) {
      return ResponseNode(errors: "You are not connected to nodes.");
    }
    return await _serverRepository.fetchNode(command, seed);
  }


  /// Request data from sharedPrefs
  Future<void> loadConfig() async {
    var lastSeed = await _sharedRepository.loadLastSeed();
    var nodesList = await _sharedRepository.loadNodesList();
    var lastBlock = await _sharedRepository.loadLastBlock();
    var delaySync = await _sharedRepository.loadDelaySync();

    appBlocConfig = appBlocConfig.copyWith(
        lastSeed: lastSeed,
        nodesList: nodesList,
        lastBlock: lastBlock,
        delaySync: delaySync);
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
