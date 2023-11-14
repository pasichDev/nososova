import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:nososova/models/app/app_bloc_config.dart';
import 'package:nososova/models/app/responses/response_node.dart';
import 'package:nososova/models/node.dart';
import 'package:nososova/models/seed.dart';
import 'package:nososova/models/summary_data.dart';

import '../models/pending_transaction.dart';
import '../repositories/repositories.dart';
import '../utils/const/network_const.dart';
import 'events/app_data_events.dart';

class AppDataState {
  final Node node;
  final StatusConnectNodes statusConnected;
  final ConnectivityResult deviceConnectedNetworkStatus;

  //wallet
  final List<PendingTransaction> pendings;
  final List<SumaryData> summaryBlock;

  AppDataState({
    this.statusConnected = StatusConnectNodes.searchNode,
    this.deviceConnectedNetworkStatus = ConnectivityResult.none,
    Node? node,
    Seed? seedActive,
    List<PendingTransaction>? pendings,
    List<SumaryData>? summaryBlock,
  })  : node = node ?? Node(seed: Seed()),
        pendings = pendings ?? [],
        summaryBlock = summaryBlock ?? [];

  AppDataState copyWith(
      {Node? node,
      StatusConnectNodes? statusConnected,
      ConnectivityResult? deviceConnectedNetworkStatus,
      List<PendingTransaction>? pendings,
      List<SumaryData>? summaryBlock}) {
    return AppDataState(
      node: node ?? this.node,
      statusConnected: statusConnected ?? this.statusConnected,
      deviceConnectedNetworkStatus:
          deviceConnectedNetworkStatus ?? this.deviceConnectedNetworkStatus,
      pendings: pendings ?? this.pendings,
      summaryBlock: summaryBlock ?? this.summaryBlock,
    );
  }
}

class AppDataBloc extends Bloc<AppDataEvent, AppDataState> {
  AppBlocConfig appBlocConfig = AppBlocConfig();
  Timer? _timerDelaySync;
  final Repositories _repositories;

  final _dataSumary = StreamController<List<SumaryData>>.broadcast();

  Stream<List<SumaryData>> get dataSumaryStream => _dataSumary.stream;

  final _pendingsSumary =
      StreamController<List<PendingTransaction>>.broadcast();

  Stream<List<PendingTransaction>> get pendingsStream => _pendingsSumary.stream;

  final _status = StreamController<StatusConnectNodes>.broadcast();

  Stream<StatusConnectNodes> get statusConnected => _status.stream;

  // TODO: Реалізація та виправлення моніторнингу мережі. Якщо мережі немає то блокувати запити та морозити всі стани
  // TODO: Окремо вести таймер перебудуваня блоку, та коли плок перебудовується потрібно ресетнути системний таймер
  AppDataBloc({
    required Repositories repositories,
  })  : _repositories = repositories,
        super(AppDataState()) {
    Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {}
    });
    on<ReconnectSeed>(_reconnectNode);
    on<InitialConnect>(_init);
  }

  Future<void> _init(AppDataEvent e, Emitter emit) async {
    await loadConfig();
    if (appBlocConfig.lastSeed != null) {
      _selectNode(InitialNodeAlgh.connectLastNode);
    } else if (appBlocConfig.nodesList != null) {
      _selectNode(InitialNodeAlgh.listenUserNodes);
    } else {
      _selectNode(InitialNodeAlgh.listenDefaultNodes);
    }
  }

  Future<void> _reconnectNode(event, emit) async {
    emit(state.copyWith(statusConnected: StatusConnectNodes.sync));

    if (event.lastNodeRun) {
      _syncDataToNode(state.node.seed);
    } else {
      await _selectNode(Random().nextInt(2) == 0
          ? InitialNodeAlgh.listenDefaultNodes
          : InitialNodeAlgh.listenUserNodes);
    }
  }

  /// Підключення та вибір ноди
  Future<void> _selectNode(InitialNodeAlgh initNodeAlgh) async {
    emit(state.copyWith(statusConnected: StatusConnectNodes.searchNode));
    ResponseNode response;

    switch (initNodeAlgh) {
      case InitialNodeAlgh.connectLastNode:
        {
          response = await _repositories.serverRepository
              .testNode(Seed().tokenizer(appBlocConfig.lastSeed));
          if (response.errors != null) {
            await _selectNode(InitialNodeAlgh.listenDefaultNodes);
            return;
          }
        }
        break;
      case InitialNodeAlgh.listenUserNodes:
        {
          var seed = Seed().tokenizer(
              _repositories.nosoCore.getRandomNode(appBlocConfig.nodesList));
          response = await _repositories.serverRepository.testNode(seed);
          if (response.errors == null) {
            var lastSeed = response.seed.toTokenizer();
            appBlocConfig = appBlocConfig.copyWith(lastSeed: lastSeed);
            _repositories.sharedRepository.saveLastSeed(lastSeed);
          }
        }

        break;
      default:
        {
          response = await _repositories.serverRepository.listenNodes();
          if (response.errors == null) {
            var lastSeed = response.seed.toTokenizer();
            appBlocConfig = appBlocConfig.copyWith(lastSeed: lastSeed);
            _repositories.sharedRepository.saveLastSeed(lastSeed);
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
          statusConnected: StatusConnectNodes.error));
    } else {
      _syncDataToNode(response.seed);
      if (_timerDelaySync != null) {
        _timerDelaySync?.cancel();
      }
      _timerDelaySync =
          Timer.periodic(Duration(seconds: appBlocConfig.delaySync), (timer) {
        _syncDataToNode(response.seed);
      });
    }
  }

  Future<void> _syncDataToNode(Seed seed) async {
    emit(state.copyWith(statusConnected: StatusConnectNodes.sync));
    final ResponseNode<List<int>> responseNodeInfo =
        await _fetchNode(NetworkRequest.nodeStatus, seed);
    final ResponseNode<List<int>> responsePendings =
        await _fetchNode(NetworkRequest.pendingsList, seed);
    final Node nodeOutput = _repositories.nosoCore
        .parseResponseNode(responseNodeInfo.value, responseNodeInfo.seed);
    final List<PendingTransaction> pendingsOutput =
        _repositories.nosoCore.parsePendings(responsePendings.value);
    if (responseNodeInfo.errors != null || responsePendings.errors != null) {
      errorInit();
      return;
    } else {
      List<SumaryData> sumaryBlock = [];

      /// Оновлення інформації коли перебудовується блок, або перщий запуск
      if (state.node.lastblock != nodeOutput.lastblock ||
          appBlocConfig.isOneStartup) {
        if (nodeOutput.pendings != 0) loadPeopleNodes(seed);

        //Отриманя summary.zip
        ResponseNode<List<int>> responseSummary =
            await _fetchNode(NetworkRequest.summary, seed);
        var isSavedSummary = await _repositories.fileRepository
            .writeSummaryZip(responseSummary.value ?? []);
        if (responseSummary.errors != null) {
          errorInit();
          return;
        } else if (isSavedSummary) {
          sumaryBlock = _repositories.nosoCore.parseSumary(
              await _repositories.fileRepository.loadSummary() ?? Uint8List(0));
          _dataSumary.add(sumaryBlock);
          if (await _checkConsensus(nodeOutput) == ConsensusStatus.sync) {
            emit(state.copyWith(
                node: nodeOutput,
                pendings: pendingsOutput,
                summaryBlock: sumaryBlock,
                statusConnected: StatusConnectNodes.connected));
            return;
          } else {
            return _selectNode(InitialNodeAlgh.listenUserNodes);
          }
        }
      }

      emit(state.copyWith(
          node: nodeOutput,
          pendings: pendingsOutput,
          statusConnected: StatusConnectNodes.connected));
      _pendingsSumary.add(pendingsOutput);
    }
  }

  Future<ConsensusStatus> _checkConsensus(Node node) async {
    return ConsensusStatus.sync;
  }

  errorInit() {
    emit(state.copyWith(
        node: state.node.copyWith(lastblock: appBlocConfig.lastBlock),
        statusConnected: StatusConnectNodes.error));
  }

  loadPeopleNodes(Seed seed) async {
    ResponseNode<List<int>> responseNodeList =
        await _fetchNode(NetworkRequest.nodeList, seed);
    if (responseNodeList.value != null) {
      var nodesPeople =
          _repositories.nosoCore.parseMNString(responseNodeList.value);
      _repositories.sharedRepository.saveNodesList(
          _repositories.nosoCore.parseMNString(responseNodeList.value));
      appBlocConfig = appBlocConfig.copyWith(lastSeed: nodesPeople);
    }
  }

  /// The base method for referencing a request to a node
  Future<ResponseNode<List<int>>> _fetchNode(String command, Seed? seed) async {
    seed ??= state.node.seed;
    if (state.statusConnected == StatusConnectNodes.error) {
      return ResponseNode(errors: "You are not connected to nodes.");
    }
    return await _repositories.serverRepository.fetchNode(command, seed);
  }

  /// Request data from sharedPrefs
  Future<void> loadConfig() async {
    var lastSeed = await _repositories.sharedRepository.loadLastSeed();
    var nodesList = await _repositories.sharedRepository.loadNodesList();
    var lastBlock = await _repositories.sharedRepository.loadLastBlock();
    var delaySync = await _repositories.sharedRepository.loadDelaySync();

    appBlocConfig = appBlocConfig.copyWith(
        lastSeed: lastSeed,
        nodesList: nodesList,
        lastBlock: lastBlock,
        delaySync: delaySync);
  }

  @override
  Future<void> close() {
    _pendingsSumary.close();
    _dataSumary.close();
    _stopTimer();
    return super.close();
  }

  void _stopTimer() {
    _timerDelaySync?.cancel();
  }
}
