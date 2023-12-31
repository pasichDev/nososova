import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:nososova/blocs/app_data_bloc.dart';
import 'package:nososova/models/app/response_page_listener.dart';
import 'package:nososova/repositories/repositories.dart';
import 'package:nososova/utils/noso/model/pending_transaction.dart';
import 'package:nososova/utils/noso/model/summary_data.dart';

import '../models/apiExplorer/transaction_history.dart';
import '../models/app/debug.dart';
import '../models/app/response_calculate.dart';
import '../models/app/state_node.dart';
import '../models/app/wallet.dart';
import '../models/responses/response_node.dart';
import '../models/seed.dart';
import '../ui/common/responses_util/response_widget_id.dart';
import '../utils/const/const.dart';
import '../utils/const/files_const.dart';
import '../utils/const/network_const.dart';
import '../utils/noso/model/address_object.dart';
import '../utils/noso/model/node.dart';
import '../utils/noso/model/order_create.dart';
import '../utils/noso/utils.dart';
import 'debug_bloc.dart';
import 'events/app_data_events.dart';
import 'events/debug_events.dart';
import 'events/wallet_events.dart';

class WalletState {
  final Wallet wallet;
  final StateNodes stateNodes;

  WalletState({Wallet? wallet, StateNodes? stateNodes})
      : wallet = wallet ?? Wallet(),
        stateNodes = stateNodes ?? StateNodes();

  WalletState copyWith({
    Wallet? wallet,
    StateNodes? stateNodes,
  }) {
    return WalletState(
      wallet: wallet ?? this.wallet,
      stateNodes: stateNodes ?? this.stateNodes,
    );
  }
}

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final AppDataBloc appDataBloc;
  final Repositories _repositories;
  final DebugBloc _debugBloc;
  bool isFirstInit = true;

  late StreamSubscription _walletEvents;
  final _walletUpdate = StreamController<bool>.broadcast();
  final _responseStatusStream =
      StreamController<ResponseListenerPage>.broadcast();

  Stream<ResponseListenerPage> get getResponseStatusStream =>
      _responseStatusStream.stream;

  WalletBloc({
    required Repositories repositories,
    required this.appDataBloc,
    required DebugBloc debugBloc,
  })  : _repositories = repositories,
        _debugBloc = debugBloc,
        super(WalletState()) {
    on<DeleteAddress>(_deleteAddress);
    on<AddAddress>(_addAddress);
    on<CreateNewAddress>(_createNewAddress);
    on<ImportWalletFile>(_importWalletFile);
    on<ImportWalletQr>(_importWalletQr);
    on<AddAddresses>(_addAddresses);
    on<SetAlias>(_setAliasAddress);
    on<SendOrder>(_sendOrder);
    on<CalculateBalance>(_calculateBalance);
    initBloc();

    _walletEvents = appDataBloc.walletEvents.listen((event) {
      add(event);
    });
  }

  /// The method used to change the alias address
  Future<void> _setAliasAddress(e, emit) async {
    var isBalanceCorrect = e.address.availableBalance >= Const.customizationFee;
    if (e.address.hash == "" || e.alias == "" || !isBalanceCorrect) {
      _responseStatusStream.add(ResponseListenerPage(
          idWidget: e.widgetId,
          codeMessage: !isBalanceCorrect ? 1 : 2,
          snackBarType: SnackBarType.error));
      return;
    }
    if (state.wallet.consensusStatus != ConsensusStatus.sync) {
      _responseStatusStream.add(ResponseListenerPage(
          idWidget: e.widgetId,
          codeMessage: 10,
          snackBarType: SnackBarType.error));
      return;
    }
    ResponseNode resp = await _repositories.networkRepository.fetchNode(
        "${NewOrderSend().getAliasOrderString(e.address, e.alias)}\n",
        appDataBloc.state.node.seed);

    if (resp.errors != null) {
      _responseStatusStream.add(ResponseListenerPage(
          idWidget: e.widgetId,
          codeMessage: 3,
          snackBarType: SnackBarType.error));
    } else {
      String resultCode = String.fromCharCodes(resp.value);
      if (int.parse(resultCode) == 0) {
        _responseStatusStream.add(ResponseListenerPage(
            idWidget: e.widgetId,
            codeMessage: 4,
            snackBarType: SnackBarType.success));

        appDataBloc.add(ReconnectSeed(true));
      } else {
        _responseStatusStream.add(ResponseListenerPage(
            idWidget: e.widgetId,
            codeMessage: 3,
            snackBarType: SnackBarType.error));
      }
    }
  }

  Future<void> _sendOrder(e, emit) async {
    var receiver = e.receiver;
    var message = e.message;
    var amount = _repositories.nosoCore.convertAmount(e.amount);
    Address address = e.address;
    var commission = _repositories.nosoCore.getFee(amount);
    var widgetId = e.widgetId;

    var isBalanceCorrect =
        _repositories.nosoCore.convertAmount(address.availableBalance) >=
            (amount + commission);

    if (receiver == "" || address.hash.isEmpty || !isBalanceCorrect) {
      _responseStatusStream.add(ResponseListenerPage(
          idWidget: widgetId,
          codeMessage: !isBalanceCorrect ? 1 : 2,
          snackBarType: SnackBarType.error));
      _debugBloc.add(AddStringDebug(
          "An attempt to send a payment was unsuccessful. Input error or not enough coins"));
      return;
    }
    if (state.wallet.consensusStatus != ConsensusStatus.sync) {
      _responseStatusStream.add(ResponseListenerPage(
          idWidget: widgetId,
          codeMessage: 10,
          snackBarType: SnackBarType.error));
      _debugBloc.add(AddStringDebug(
          "An attempt to send a payment was unsuccessful. The system is not synchronized with the network"));
      return;
    }
    var sendString = NewOrderSend().getOrderString(address, message, receiver,
        amount, commission, appDataBloc.state.node.lastblock, _getTrxCount());
    var sendStringParse = sendString.split(" ");

    ResponseNode resp = await _repositories.networkRepository
        .fetchNode("$sendString\n", appDataBloc.state.node.seed);
    var result = String.fromCharCodes(resp.value).split(' ');

    if (result.length == 1) {
      _responseStatusStream.add(ResponseListenerPage(
          idWidget: e.widgetId,
          codeMessage: 4,
          actionValue: TransactionHistory(
              blockId: appDataBloc.state.node.lastblock,
              id: sendStringParse[7],
              timestamp: sendStringParse[3],
              sender: address.nameAddressFull,
              amount: e.amount.toString(),
              fee: (commission / 100000000).toStringAsFixed(8),
              type: sendStringParse[9],
              receiver: receiver),
          snackBarType: SnackBarType.ignore));
      _debugBloc.add(AddStringDebug(
          "New payment has been created, ID -> ${sendStringParse[7]}"));
      appDataBloc.add(ReconnectSeed(true));
    } else {
      if (int.parse(result[1]) == 11) {
        _responseStatusStream.add(ResponseListenerPage(
            idWidget: e.widgetId,
            codeMessage: 11,
            snackBarType: SnackBarType.error));
        _debugBloc.add(AddStringDebug(
            "An attempt to send a payment was unsuccessful. Address blocked"));
        return;
      }
      if (int.parse(result[1]) == 10) {
        _responseStatusStream.add(ResponseListenerPage(
            idWidget: e.widgetId,
            codeMessage: 13,
            snackBarType: SnackBarType.error));
        _debugBloc.add(AddStringDebug(
            "An attempt to send a payment was unsuccessful. Address blocked"));
        return;
      }

      _responseStatusStream.add(ResponseListenerPage(
          idWidget: e.widgetId,
          codeMessage: 12,
          snackBarType: SnackBarType.error));
      _debugBloc.add(
          AddStringDebug("Your request is successful and has been processed"));
      return;
    }
  }

  initBloc() async {
    final addressStream = _repositories.localRepository.fetchAddress();
    await for (final addressList in addressStream) {
      if (isFirstInit) {
        isFirstInit = false;
        emit(state.copyWith(
            wallet: state.wallet.copyWith(address: addressList)));
      } else {
        add(CalculateBalance(state.wallet.summary, false, addressList));
      }
    }
  }

  void _createNewAddress(event, emit) async {
    await _repositories.localRepository
        .addAddress(_repositories.nosoCore.createNewAddress());
  }

  void _addAddress(event, emit) async {
    await _repositories.localRepository.addAddress(event.address);
  }

  void _deleteAddress(event, emit) async {
    await _repositories.localRepository.deleteAddress(event.address);
  }

  void _addAddresses(event, emit) async {
    List<Address> listAddresses = [];

    for (Address newAddress in event.addresses) {
      Address? found = state.wallet.address.firstWhere(
          (other) => other.hash == newAddress.hash,
          orElse: () => Address(hash: "", publicKey: "", privateKey: ""));

      if (found.hash.isEmpty) {
        listAddresses.add(newAddress);
      }
    }

    if (listAddresses.isEmpty) {
      _responseStatusStream.add(ResponseListenerPage(
          idWidget: ResponseWidgetsIds.widgetImportAddress,
          codeMessage: 8,
          snackBarType: SnackBarType.error));
    } else {
      await _repositories.localRepository.addAddresses(listAddresses);
      _responseStatusStream.add(ResponseListenerPage(
          idWidget: ResponseWidgetsIds.widgetImportAddress,
          codeMessage: 7,
          snackBarType: SnackBarType.success));
    }
  }

  /// TODO Додати функцію оновлення вузлів запущених
  void _calculateBalance(event, emit) async {
    var summary =
        event.summaryData.isEmpty ? state.wallet.summary : event.summaryData;
    var listAddresses = event.address ?? state.wallet.address;
    var checkConsensus = event.checkConsensus;
    var targetNode = appDataBloc.state.node;
    ResponseCalculate calculateResponse = ResponseCalculate(
        totalIncoming: state.wallet.totalIncoming,
        totalOutgoing: state.wallet.totalOutgoing,
        totalBalance: state.wallet.balanceTotal);
    var consensusReturn = state.wallet.consensusStatus;
    var stateNodes = state.stateNodes;

    if (checkConsensus) {
      consensusReturn = await _checkConsensus(targetNode);
      if (consensusReturn == ConsensusStatus.sync) {
        _debugBloc.add(AddStringDebug(
            "Consensus is correct, branch: ${targetNode.branch}",
            DebugType.success));
        calculateResponse = await _syncBalance(summary, address: listAddresses);
        listAddresses = calculateResponse.address;
      } else {
        _debugBloc.add(AddStringDebug(
            "Consensus is incorrect, let's try to reconnect", DebugType.error));
        emit(state.copyWith(
            wallet: state.wallet.copyWith(
                summary: [], consensusStatus: ConsensusStatus.error)));
        appDataBloc.add(ReconnectSeed(false));
        return;
      }
    } else if (consensusReturn == ConsensusStatus.sync && !checkConsensus) {
      calculateResponse = await _syncBalance(summary, address: listAddresses);
      listAddresses = calculateResponse.address;
    }

    List<PendingTransaction> pendingsParse = [];
    if (targetNode.pendings != 0) {
      var responsePendings = await _repositories.networkRepository
          .fetchNode(NetworkRequest.pendingsList, targetNode.seed);
      pendingsParse =
          _repositories.nosoCore.parsePendings(responsePendings.value);
      if (responsePendings.errors != null || pendingsParse.isEmpty) {
        _debugBloc.add(
            AddStringDebug("Error getting pendings, try another connection"));
        emit(state.copyWith(
            wallet: state.wallet.copyWith(
                summary: [], consensusStatus: ConsensusStatus.error)));
        appDataBloc.add(SyncResult(false));
      }
    }

    _debugBloc.add(AddStringDebug(
        "Pendings have been processed, we are completing synchronization"));
    var calculatePendings = await _syncPendings(pendingsParse, listAddresses);
    listAddresses = listAddresses;
    calculateResponse = calculateResponse.copyWith(
        totalOutgoing: calculatePendings.totalOutgoing,
        totalIncoming: calculatePendings.totalIncoming);

    /// getInfoActiveNodes
    stateNodes = _getActiveNodesInfo(
        stateNodes, appDataBloc.appBlocConfig.nodesList ?? "", listAddresses);

    emit(state.copyWith(
        stateNodes: stateNodes,
        wallet: state.wallet.copyWith(
            address: listAddresses,
            summary: summary,
            pendings: pendingsParse,
            consensusStatus: consensusReturn,
            balanceTotal: calculateResponse.totalBalance,
            totalIncoming: calculateResponse.totalIncoming,
            totalOutgoing: calculateResponse.totalOutgoing)));

    appDataBloc.add(SyncResult(true));
  }

  StateNodes _getActiveNodesInfo(
      StateNodes stateNodes, String totalNodes, List<Address> listAddresses) {
    List<String> nodesList = totalNodes.split(',');
    var nodeRewardDay = appDataBloc.state.statisticsCoin.getBlockDayNodeReward;

    if (nodesList.isNotEmpty) {
      List<Address> listUserNodes = [];
      bool containsSeedWallet(String address) =>
          nodesList.any((itemNode) => address == itemNode.split("|")[1]);

      for (Address address in listAddresses) {
        if (address.balance >= UtilsDataNoso.getCountMonetToRunNode()) {
          address.nodeAvailable = true;
          address.nodeStatusOn = containsSeedWallet(address.hash);
          address.rewardDay = address.nodeStatusOn ? nodeRewardDay : 0;
          listUserNodes.add(address);
        } else {
          address.nodeAvailable = false;
          address.nodeStatusOn = false;
          address.rewardDay = 0;
        }
      }
      var launched =
          listUserNodes.where((item) => item.nodeStatusOn == true).length;

      return stateNodes.copyWith(
          launchedNodes: launched,
          rewardDay: nodeRewardDay * launched,
          nodes: listUserNodes);
    }

    return stateNodes;
  }

  /// Method that checks the consensus for correctness
  /// It selects two nodes from the verified nodes and 3 nodes from the custom nodes for consensus verification
  Future<ConsensusStatus> _checkConsensus(Node targetNode) async {
    List<Node> testNodes = [];
    List<bool> decisionNodes = [];
    var listNodesUsers = appDataBloc.appBlocConfig.nodesList;

    int maxDevAttempts = 2;
    int maxDevFalseAttempts = 4;
    int attemptsDev = 0;
    do {
      var targetDevNode =
          await _repositories.networkRepository.getRandomDevNode();
      final Node? nodeOutput = _repositories.nosoCore
          .parseResponseNode(targetDevNode.value, targetDevNode.seed);
      if (targetDevNode.errors != null ||
          nodeOutput == null ||
          testNodes.any((node) =>
              node.seed.ip == targetDevNode.seed.ip ||
              targetNode.seed.ip == targetDevNode.seed.ip)) {
        maxDevFalseAttempts++;
      } else {
        testNodes.add(nodeOutput);
        attemptsDev++;
      }
    } while (attemptsDev < maxDevAttempts && attemptsDev < maxDevFalseAttempts);

    int maxUserAttempts = testNodes.length == 2
        ? listNodesUsers == null || listNodesUsers.isEmpty
            ? 2
            : 1
        : 3;
    int attemptsUser = 0;

    do {
      var randomSeed = Seed()
          .tokenizer(_repositories.nosoCore.getRandomNode(listNodesUsers));
      var targetUserNode = await _repositories.networkRepository
          .fetchNode(NetworkRequest.nodeStatus, randomSeed);

      final Node? nodeUserOutput = _repositories.nosoCore
          .parseResponseNode(targetUserNode.value, targetUserNode.seed);

      if (targetUserNode.errors != null ||
          nodeUserOutput == null ||
          testNodes.any((node) =>
              node.seed.ip == targetUserNode.seed.ip ||
              targetNode.seed.ip == targetUserNode.seed.ip)) {
      } else {
        testNodes.add(nodeUserOutput);
        attemptsUser++;
      }
    } while (attemptsUser < maxUserAttempts);

    for (Node tNode in testNodes) {
      decisionNodes.add(isValidNode(tNode, targetNode));
    }
    if (decisionNodes.every((element) => element == true)) {
      return ConsensusStatus.sync;
    } else {
      return ConsensusStatus.error;
    }
  }

  /// Method that checks the connection between two nodes, and returns true if the required data matches
  bool isValidNode(Node tNode, Node targetNode) {
    if (tNode.branch == targetNode.branch ||
        tNode.lastblock == targetNode.lastblock) {
      return true;
    }
    return false;
  }

  /// Method that synchronizes the balance of the wallet with the available one
  Future<ResponseCalculate> _syncBalance(List<SumaryData> summary,
      {List<Address>? address}) async {
    var listAddress = address ?? state.wallet.address;

    double totalBalance = 0;
    for (var address in listAddress) {
      SumaryData found = summary.firstWhere(
          (other) => other.hash == address.hash,
          orElse: () => SumaryData());

      if (found.hash.isNotEmpty) {
        totalBalance += found.balance;
        address.balance = found.balance;
        address.lastOP = found.lastOP;
        address.score = found.score;
        address.custom = found.custom.isEmpty ? null : found.custom;
        address.nodeAvailable =
            found.balance >= UtilsDataNoso.getCountMonetToRunNode();
      }
    }
    return ResponseCalculate(address: listAddress, totalBalance: totalBalance);
  }

  /// Method that synchronizes pendings
  Future<ResponseCalculate> _syncPendings(
      List<PendingTransaction> pendings, List<Address> address) async {
    double totalOutgoing = 0;
    double totalIncoming = 0;

    var calculateListAddress = address;

    for (var address in calculateListAddress) {
      List<PendingTransaction> foundReceivers =
          pendings.where((other) => other.receiver == address.hash).toList();

      List<PendingTransaction> foundSenders =
          pendings.where((other) => other.sender == address.hash).toList();

      address.incoming = 0;
      address.outgoing = 0;

      if (foundReceivers.isNotEmpty) {
        for (var pending in foundReceivers) {
          totalIncoming += pending.amountTransfer;
          address.incoming += pending.amountTransfer;
        }
      }
      if (foundSenders.isNotEmpty) {
        for (var pending in foundSenders) {
          var cell = pending.amountTransfer + pending.amountFee;
          totalOutgoing += cell;
          address.outgoing += cell;
        }
      }
    }

    return ResponseCalculate(
        address: calculateListAddress,
        totalIncoming: totalIncoming,
        totalOutgoing: totalOutgoing);
  }

  int _getTrxCount() {
    var calculateListAddress = state.wallet.address;
    var pendingsList = state.wallet.pendings;
    int countTrx = 0;

    for (var address in calculateListAddress) {
      List<PendingTransaction> foundReceivers = pendingsList
          .where((other) => other.receiver == address.hash)
          .toList();
      List<PendingTransaction> foundSenders =
          pendingsList.where((other) => other.sender == address.hash).toList();

      countTrx += foundReceivers.length + foundSenders.length;
    }

    print("Count trx -> $countTrx");
    return countTrx == 0 ? 1 : countTrx;
  }

  /// This method receives a file and processes its contents, and returns the contents of the file for confirmation
  void _importWalletFile(event, emit) async {
    final FilePickerResult? result = event.filePickerResult;
    if (result != null) {
      var file = result.files.first;
      if (file.extension?.toLowerCase() == FilesConst.pkwExtensions) {
        var bytes =
            await _repositories.fileRepository.readBytesFromPlatformFile(file);
        var listAddress = _repositories.nosoCore.parseExternalWallet(bytes);

        if (listAddress.isNotEmpty) {
          _responseStatusStream.add(ResponseListenerPage(
              idWidget: ResponseWidgetsIds.widgetImportAddress,
              codeMessage: 0,
              action: ActionsFileWallet.walletOpen,
              actionValue: listAddress));
        } else {
          _responseStatusStream.add(ResponseListenerPage(
              idWidget: ResponseWidgetsIds.widgetImportAddress,
              codeMessage: 5,
              snackBarType: SnackBarType.error));
        }
      } else {
        _responseStatusStream.add(ResponseListenerPage(
            idWidget: ResponseWidgetsIds.widgetImportAddress,
            codeMessage: 6,
            snackBarType: SnackBarType.error));
      }
    }
  }

  /// This method is called after scanning the QR code, and passes an event to open a dialog to confirm the import
  void _importWalletQr(event, emit) async {
    var address =
        _repositories.nosoCore.importAddressForKeysPair(event.addressKeys);
    if (address != null) {
      _responseStatusStream.add(ResponseListenerPage(
          idWidget: ResponseWidgetsIds.widgetImportAddress,
          actionValue: [address],
          action: ActionsFileWallet.walletOpen));
    }
  }

  @override
  Future<void> close() {
    _walletUpdate.close();
    _walletEvents.cancel();
    return super.close();
  }
}
