import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:nososova/blocs/debug_bloc.dart';
import 'package:nososova/blocs/events/wallet_events.dart';
import 'package:nososova/models/apiExplorer/block_info.dart';
import 'package:nososova/models/app/app_bloc_config.dart';
import 'package:nososova/models/seed.dart';
import 'package:nososova/utils/noso/model/node.dart';
import 'package:nososova/utils/noso/model/summary_data.dart';
import 'package:nososova/utils/status_api.dart';

import '../models/app/debug.dart';
import '../models/app/stats.dart';
import '../models/responses/response_node.dart';
import '../repositories/repositories.dart';
import '../utils/const/network_const.dart';
import 'events/app_data_events.dart';
import 'events/debug_events.dart';

class AppDataState {
  final Node node;
  final StatusConnectNodes statusConnected;
  final StatisticsCoin statisticsCoin;

  AppDataState({
    this.statusConnected = StatusConnectNodes.searchNode,
    Node? node,
    StatisticsCoin? statisticsCoin,
  })  : node = node ?? Node(seed: Seed()),
        statisticsCoin = statisticsCoin ?? StatisticsCoin();

  AppDataState copyWith(
      {Node? node,
      StatisticsCoin? statisticsCoin,
      StatusConnectNodes? statusConnected,}) {
    return AppDataState(
      node: node ?? this.node,
      statisticsCoin: statisticsCoin ?? this.statisticsCoin,
      statusConnected: statusConnected ?? this.statusConnected,
     );
  }
}

class AppDataBloc extends Bloc<AppDataEvent, AppDataState> {
  AppBlocConfig appBlocConfig = AppBlocConfig();
  final DebugBloc _debugBloc;
  Timer? timerSyncNetwork;
  final Repositories _repositories;

  final _walletEvent = StreamController<WalletEvent>.broadcast();

  Stream<WalletEvent> get walletEvents => _walletEvent.stream;

  AppDataBloc({
    required Repositories repositories,
    required DebugBloc debugBloc,
  })  : _repositories = repositories,
        _debugBloc = debugBloc,
        super(AppDataState()) {
    on<ReconnectSeed>(_reconnectNode);
    on<InitialConnect>(_init);
    on<SyncResult>(_syncResult);
  }

  /// This method initializes the first network connection
  Future<void> _init(event, emit) async {
    _debugBloc.add(AddStringDebug("First network connection"));
    await loadConfig();

    if (appBlocConfig.lastSeed != null) {
      await _selectTargetNode(event, emit, InitialNodeAlgh.connectLastNode);
    } else if (appBlocConfig.nodesList != null) {
      await _selectTargetNode(event, emit, InitialNodeAlgh.listenUserNodes);
    } else {
      await _selectTargetNode(event, emit, InitialNodeAlgh.listenDefaultNodes);
    }
  }

  Future<void> _reconnectNode(event, emit) async {
    if (state.statusConnected == StatusConnectNodes.sync && event.lastNodeRun) {
      return;
    }
    _stopTimerSyncNetwork();
    if (event.lastNodeRun) {
      emit(state.copyWith(statusConnected: StatusConnectNodes.sync));
      _debugBloc.add(AddStringDebug("Updating data from the last node"));
      await _selectTargetNode(event, emit, InitialNodeAlgh.connectLastNode,
          repeat: true);
    } else {
      _debugBloc.add(AddStringDebug("Reconnecting to new node"));
      await _selectTargetNode(event, emit, getRandomAlgorithm());
    }
  }

  /// This method implements the selection of the node to which we will connect in the future
  Future<void> _selectTargetNode(event, emit, InitialNodeAlgh initAlgh,
      {bool repeat = false}) async {
    if (!repeat) {
      emit(state.copyWith(statusConnected: StatusConnectNodes.searchNode));
      _debugBloc.add(AddStringDebug("Active node search"));
    } else {
      _debugBloc.add(AddStringDebug(
          "Repeated attempt to search for a node, the last one ended in failure"));
    }


    ResponseNode<List<int>> responseTargetNode =
        await _searchTargetNode(initAlgh);
    final Node? nodeOutput = _repositories.nosoCore
        .parseResponseNode(responseTargetNode.value, responseTargetNode.seed);
    if (responseTargetNode.errors == null && nodeOutput != null) {
      await _syncNetwork(event, emit, nodeOutput);
    } else {
      _debugBloc.add(AddStringDebug(
          "The node did not respond properly -> ${responseTargetNode.seed.toTokenizer()}"));
      _debugBloc.add(AddStringDebug("Reconnecting to new node"));
      await _selectTargetNode(event, emit, getRandomAlgorithm(), repeat: true);
    }
  }

  /// A method that selects a random algorithm type
  InitialNodeAlgh getRandomAlgorithm() {
    return Random().nextInt(2) == 0
        ? InitialNodeAlgh.listenDefaultNodes
        : InitialNodeAlgh.listenUserNodes;
  }

  /// A method that tests and returns the active node
  Future<ResponseNode<List<int>>> _searchTargetNode(
      InitialNodeAlgh initAlgh) async {
    var listUsersNodes = appBlocConfig.nodesList;
    if ((listUsersNodes ?? "").isEmpty) {
      initAlgh = InitialNodeAlgh.listenDefaultNodes;
    }

    switch (initAlgh) {
      case InitialNodeAlgh.connectLastNode:
        return await _repositories.networkRepository.fetchNode(
            NetworkRequest.nodeStatus,
            Seed().tokenizer(appBlocConfig.lastSeed));

      case InitialNodeAlgh.listenUserNodes:
        return await _repositories.networkRepository.fetchNode(
            NetworkRequest.nodeStatus,
            Seed().tokenizer(
                _repositories.nosoCore.getRandomNode(listUsersNodes)));

      default:
        return await _repositories.networkRepository.getRandomDevNode();
    }
  }

  Future<void> _syncNetwork(event, emit, Node targetNode) async {
    emit(state.copyWith(statusConnected: StatusConnectNodes.sync));
    _debugBloc.add(AddStringDebug(
        "Getting information from the node ${targetNode.seed.toTokenizer()}"));

    var statsCopyCoin = state.statisticsCoin;
    var responsePriceHistory =
        await _repositories.networkRepository.fetchHistoryPrice();
    statsCopyCoin = responsePriceHistory.errors == null
        ? statsCopyCoin.copyWith(
            historyCoin: responsePriceHistory.value,
            lastBlock: targetNode.lastblock)
        : statsCopyCoin.copyWith(
            lastBlock: targetNode.lastblock, apiStatus: ApiStatus.error);

    if (state.node.lastblock != targetNode.lastblock ||
        state.node.seed.ip != targetNode.seed.ip) {
      var responseLastBlockInfo =
          await _repositories.networkRepository.fetchLastBlockInfo();

      if (responseLastBlockInfo.errors == null) {
        BlockInfo blockInfo = responseLastBlockInfo.value;
        if (blockInfo.masternodes.isNotEmpty) {
          _repositories.sharedRepository
              .saveNodesList(blockInfo.getMasternodesString());
          appBlocConfig = appBlocConfig.copyWith(
              nodesList: blockInfo.getMasternodesString());
          _debugBloc.add(AddStringDebug(
              "The list of active nodes is updated, currently they are -> ${blockInfo.count}"));
        } else {
          _debugBloc
              .add(AddStringDebug("The list of active nodes is not updated"));
        }

        statsCopyCoin = statsCopyCoin.copyWith(
            totalNodes: blockInfo.count,
            reward: blockInfo.reward,
            apiStatus: ApiStatus.connected);
        _debugBloc.add(AddStringDebug(
            "Obtaining information about the block is successful ${targetNode.lastblock}"));
      } else {
        _debugBloc
            .add(AddStringDebug("Block information not received, skipped"));
        _debugBloc.add(AddStringDebug(
            "Error: ${responseLastBlockInfo.errors}", DebugType.error));
        statsCopyCoin = statsCopyCoin.copyWith(apiStatus: ApiStatus.error);
      }

      ResponseNode<List<int>> responseSummary = await _repositories
          .networkRepository
          .fetchNode(NetworkRequest.summary, targetNode.seed);
      var isSavedSummary = await _repositories.fileRepository
          .writeSummaryZip(responseSummary.value ?? []);
      if (responseSummary.errors == null && isSavedSummary) {
        List<SumaryData> sumaryBlock = _repositories.nosoCore.parseSumary(
            await _repositories.fileRepository.loadSummary() ?? Uint8List(0));
        double totalCoins = sumaryBlock.fold(
            0, (double sum, SumaryData data) => sum + data.balance);
        statsCopyCoin = statsCopyCoin.copyWith(totalCoin: totalCoins);
        _debugBloc.add(AddStringDebug("Download Summary successful"));

        emit(state.copyWith(
            node: targetNode,
            statusConnected: StatusConnectNodes.consensus,
            statisticsCoin: statsCopyCoin));

        _walletEvent.add(CalculateBalance(sumaryBlock, true, null));

        return;
      } else {
        _debugBloc.add(AddStringDebug(
            "Error processing Summary, trying to reconnect", DebugType.error));
        add(ReconnectSeed(false));
        return;
      }
    }

    emit(state.copyWith(
        node: targetNode,
        statusConnected: StatusConnectNodes.connected,
        statisticsCoin: statsCopyCoin));

    if (targetNode.pendings != 0) {
      _walletEvent.add(CalculateBalance([], false, null));
    } else {
      add(SyncResult(true));
    }

    return;
  }

  /// The method that receives the response about the synchronization status in WalletBloc
  Future<void> _syncResult(event, emit) async {
    var success = event.success;
    if (success) {
      emit(state.copyWith(statusConnected: StatusConnectNodes.connected));
      _repositories.sharedRepository
          .saveLastSeed(state.node.seed.toTokenizer());
      appBlocConfig =
          appBlocConfig.copyWith(lastSeed: state.node.seed.toTokenizer());
      _debugBloc.add(AddStringDebug(
          "Synchronization is complete, the application is ready to work with the network",
          DebugType.success));
      _startTimerSyncNetwork();
    } else {
      add(ReconnectSeed(false));
    }
  }

  /// Method that starts a timer that simulates updating information
  void _startTimerSyncNetwork() {
    timerSyncNetwork =
        Timer.periodic(Duration(seconds: appBlocConfig.delaySync), (timer) {
      add(ReconnectSeed(true));
    });
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
    _stopTimerSyncNetwork();
    return super.close();
  }

  void _stopTimerSyncNetwork() {
    timerSyncNetwork?.cancel();
  }
}
