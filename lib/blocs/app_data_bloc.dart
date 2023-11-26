import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:nososova/blocs/debug_bloc.dart';
import 'package:nososova/models/app/app_bloc_config.dart';
import 'package:nososova/models/app/info_coin.dart';
import 'package:nososova/models/app/responses/response_api.dart';
import 'package:nososova/models/app/responses/response_node.dart';
import 'package:nososova/models/node.dart';
import 'package:nososova/models/seed.dart';
import 'package:nososova/models/summary_data.dart';

import '../models/app/parse_mn_info.dart';
import '../models/app/stats.dart';
import '../models/block_mns.dart';
import '../models/pending_transaction.dart';
import '../repositories/repositories.dart';
import '../utils/const/network_const.dart';
import 'events/app_data_events.dart';
import 'events/debug_events.dart';

class AppDataState {
  final Node node;
  final StatusConnectNodes statusConnected;
  final ConnectivityResult deviceConnectedNetworkStatus;
  final StatsInfoCoin statsInfoCoin;

  //wallet
  final List<PendingTransaction> pendings;
  final List<SumaryData> summaryBlock;
  final List<Seed> listPeopleNodes;

  AppDataState({
    this.statusConnected = StatusConnectNodes.searchNode,
    this.deviceConnectedNetworkStatus = ConnectivityResult.none,
    Node? node,
    StatsInfoCoin? statsInfoCoin,
    InfoCoin? infoCoin,
    Seed? seedActive,
    List<PendingTransaction>? pendings,
    List<SumaryData>? summaryBlock,
    List<Seed>? listPeopleNodes,
  })  : node = node ?? Node(seed: Seed()),
        statsInfoCoin = statsInfoCoin ??
            StatsInfoCoin(
                blockInfo: BlockMNS_RPC(total: 0, reward: 0, block: 0)),
        pendings = pendings ?? [],
        summaryBlock = summaryBlock ?? [],
        listPeopleNodes = listPeopleNodes ?? [];

  AppDataState copyWith(
      {Node? node,
      StatsInfoCoin? statsInfoCoin,
      StatusConnectNodes? statusConnected,
      ConnectivityResult? deviceConnectedNetworkStatus,
      List<PendingTransaction>? pendings,
      List<Seed>? listPeopleNodes,
      List<SumaryData>? summaryBlock}) {
    return AppDataState(
      node: node ?? this.node,
      statsInfoCoin: statsInfoCoin ?? this.statsInfoCoin,
      statusConnected: statusConnected ?? this.statusConnected,
      deviceConnectedNetworkStatus:
          deviceConnectedNetworkStatus ?? this.deviceConnectedNetworkStatus,
      pendings: pendings ?? this.pendings,
      summaryBlock: summaryBlock ?? this.summaryBlock,
      listPeopleNodes: listPeopleNodes ?? this.listPeopleNodes,
    );
  }
}

class AppDataBloc extends Bloc<AppDataEvent, AppDataState> {
  AppBlocConfig appBlocConfig = AppBlocConfig();
  DebugBloc _debugBloc;
  Timer? _timerDelaySync;
  final Repositories _repositories;

  final _dataSumary = StreamController<List<SumaryData>>.broadcast();

  Stream<List<SumaryData>> get dataSumaryStream => _dataSumary.stream;

  final _pendingsSumary =
      StreamController<List<PendingTransaction>>.broadcast();

  Stream<List<PendingTransaction>> get pendingsStream => _pendingsSumary.stream;

  final _status = StreamController<StatusConnectNodes>.broadcast();

  Stream<StatusConnectNodes> get statusConnected => _status.stream;

  // TODO: Окремо вести таймер перебудуваня блоку, та коли плок перебудовується потрібно ресетнути системний таймер
  AppDataBloc({
    required Repositories repositories,
    required DebugBloc debugBloc,
  })  : _repositories = repositories,
        _debugBloc = debugBloc,
        super(AppDataState()) {
    Connectivity().onConnectivityChanged.listen((result) {
      emit(state.copyWith(deviceConnectedNetworkStatus: result));
    });
    on<ReconnectSeed>(_reconnectNode);
    on<InitialConnect>(_init);
  }

  Future<void> _init(AppDataEvent e, Emitter emit) async {
    _debugBloc.add(AddStringDebug("Network initialization"));
    await loadConfig();
    if (appBlocConfig.lastSeed != null) {
      await _selectNode(InitialNodeAlgh.connectLastNode);
    } else if (appBlocConfig.nodesList != null) {
      await _selectNode(InitialNodeAlgh.listenUserNodes);
    } else {
      await _selectNode(InitialNodeAlgh.listenDefaultNodes);
    }
  }

  ///Коли робимо рестарт потрібно, зупинити таймер оновення та запустити новий
  Future<void> _reconnectNode(event, emit) async {
    emit(state.copyWith(statusConnected: StatusConnectNodes.sync));

    if (event.lastNodeRun) {
      _debugBloc.add(AddStringDebug("Manual update of information"));
      _syncDataToNode(state.node.seed);
    } else {

      _debugBloc.add(AddStringDebug("Attempting to modify a node"));
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
        _debugBloc.add(AddStringDebug("----------------------"));
        _debugBloc.add(AddStringDebug("Updating data"));
        _syncDataToNode(response.seed);
      });
    }
  }

  Future<void> _syncDataToNode(Seed seed) async {
    ///init var && send state loading
    emit(state.copyWith(statusConnected: StatusConnectNodes.sync));
    var responsePendings = ResponseNode(errors: null);
    List<PendingTransaction> pendingsOutput = [];
    List<SumaryData> sumaryBlock = [];

    _debugBloc.add(AddStringDebug("We connect to the node ${seed.ip}"));
    final ResponseNode<List<int>> responseNodeInfo =
        await _fetchNode(NetworkRequest.nodeStatus, seed);
    if (responseNodeInfo.errors != null) {
      _debugBloc.add(AddStringDebug(responseNodeInfo.errors ?? ""));
      return errorInit();
    }

    final Node nodeOutput = _repositories.nosoCore
        .parseResponseNode(responseNodeInfo.value, responseNodeInfo.seed);

    /// Loading pendings
    if (nodeOutput.pendings != 0) {
      _debugBloc.add(AddStringDebug("Request pending"));
      responsePendings = await _fetchNode(NetworkRequest.pendingsList, seed);
      if (responsePendings.errors != null) {
        _debugBloc.add(AddStringDebug(responsePendings.errors ?? ""));
        return errorInit();
      }
      pendingsOutput =
          _repositories.nosoCore.parsePendings(responsePendings.value);
    }

    /// Оновлення інформації коли перебудовується блок, або перщий запуск

    if (state.node.lastblock != nodeOutput.lastblock ||
        appBlocConfig.isOneStartup) {
      _debugBloc.add(AddStringDebug(
          "Loading information for block ${nodeOutput.lastblock}"));
      var parseMn = await loadPeopleNodes(seed);
      ResponseApi blockInfo = await _repositories.liveCoinWatchRepository
          .fetchBlockInfo(nodeOutput.lastblock);
      //Отриманя summary.zip
      ResponseNode<List<int>> responseSummary =
          await _fetchNode(NetworkRequest.summary, seed);
      if (responseSummary.errors != null) {
        return errorInit();
      }
      var isSavedSummary = await _repositories.fileRepository
          .writeSummaryZip(responseSummary.value ?? []);
      if (!isSavedSummary) {
        return errorInit();
      }
      sumaryBlock = _repositories.nosoCore.parseSumary(
          await _repositories.fileRepository.loadSummary() ?? Uint8List(0));

      if (await _checkConsensus(nodeOutput) == ConsensusStatus.sync) {
        double totalCoins = sumaryBlock.fold(
            0, (double sum, SumaryData data) => sum + data.balance);

        emit(state.copyWith(
          node: nodeOutput,
          pendings: pendingsOutput,
          summaryBlock: sumaryBlock,
          statusConnected: StatusConnectNodes.connected,
          listPeopleNodes: parseMn.listNodes,
          statsInfoCoin: state.statsInfoCoin.copyWith(
              blockInfo: blockInfo.value,
              totalCoin: totalCoins.toInt(),
              totalNodesPeople: parseMn.count),
        ));
        _dataSumary.add(sumaryBlock);
        _debugBloc.add(AddStringDebug("Synchronization is successful"));
        return;
      } else {
        _debugBloc.add(
            AddStringDebug("Reconnecting because the consensus is incorrect"));
        return _selectNode(InitialNodeAlgh.listenUserNodes);
      }
    }

    emit(state.copyWith(
        node: nodeOutput,
        pendings: pendingsOutput,
        statusConnected: StatusConnectNodes.connected));
    _pendingsSumary.add(pendingsOutput);
    _debugBloc.add(AddStringDebug("Data update successful"));
  }

  Future<ConsensusStatus> _checkConsensus(Node node) async {
    _debugBloc.add(AddStringDebug("Consensus check"));
    return ConsensusStatus.sync;
  }

  errorInit() {
    emit(state.copyWith(
        node: state.node.copyWith(lastblock: appBlocConfig.lastBlock),
        statusConnected: StatusConnectNodes.error));
  }

  Future<ParseMNInfo> loadPeopleNodes(Seed seed) async {
    ResponseNode<List<int>> responseNodeList =
        await _fetchNode(NetworkRequest.nodeList, seed);
    if (responseNodeList.value != null) {
      var nodesPeople =
          _repositories.nosoCore.parseMNString(responseNodeList.value);
      _repositories.sharedRepository.saveNodesList(nodesPeople.nodes);
      appBlocConfig = appBlocConfig.copyWith(nodesList: nodesPeople.nodes);
      return nodesPeople;
    }
    return ParseMNInfo();
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
