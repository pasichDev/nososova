import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:nososova/blocs/app_data_bloc.dart';
import 'package:nososova/models/app/response_page_listener.dart';
import 'package:nososova/models/pending_transaction.dart';
import 'package:nososova/models/summary_data.dart';
import 'package:nososova/repositories/repositories.dart';

import '../models/app/responses/response_node.dart';
import '../models/app/wallet.dart';
import '../ui/responses_util/response_widget_id.dart';
import '../utils/const/const.dart';
import '../utils/const/files_const.dart';
import '../utils/noso/model/order_create.dart';
import '../utils/noso/src/address_object.dart';
import '../utils/noso/utils.dart';
import 'events/app_data_events.dart';
import 'events/wallet_events.dart';

class WalletState {
  final Wallet wallet;

  WalletState({Wallet? wallet}) : wallet = wallet ?? Wallet();

  WalletState copyWith({
    Wallet? wallet,
  }) {
    return WalletState(
      wallet: wallet ?? this.wallet,
    );
  }
}

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final AppDataBloc appDataBloc;
  final Repositories _repositories;
  late StreamSubscription _summarySubscriptions;
  late StreamSubscription _pendingsSubscriptions;

  final _walletUpdate = StreamController<bool>.broadcast();

  Stream<bool> get walletUpdate => _walletUpdate.stream;

  final _responseStatusStream =
      StreamController<ResponseListenerPage>.broadcast();

  Stream<ResponseListenerPage> get getResponseStatusStream =>
      _responseStatusStream.stream;

  WalletBloc({
    required Repositories repositories,
    required this.appDataBloc,
  })  : _repositories = repositories,
        super(WalletState()) {
    on<FetchAddress>(_fetchAddresses);
    on<DeleteAddress>(_deleteAddress);
    on<AddAddress>(_addAddress);
    on<CreateNewAddress>(_createNewAddress);
    on<ImportWalletFile>(_importWalletFile);
    on<ImportWalletQr>(_importWalletQr);
    on<AddAddresses>(_addAddresses);
    on<SetAlias>(_setAliasAddress);
    initBloc();
  }

  /// The method used to change the alias address
  Future<void> _setAliasAddress(e, emit) async {
    var isBalanceCorrect = e.address.availableBalance > Const.customizationFee;
    if (e.address.hash == "" || e.alias == "" || !isBalanceCorrect) {
      _responseStatusStream.add(ResponseListenerPage(
          idWidget: e.widgetId,
          codeMessage: !isBalanceCorrect ? 1 : 2,
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
    print("sendOrder");
    //print(e.value);
    ResponseNode resp = await _repositories.networkRepository
        .fetchNode("${e.value}\n", appDataBloc.state.node.seed);

    print(resp.value);
  }

  initBloc() async {
    _summarySubscriptions = appDataBloc.dataSumaryStream.listen((data) {
      _syncBalance(data);
    });
    _pendingsSubscriptions = appDataBloc.pendingsStream.listen((data) {
      _syncPendings(data);
    });

    final addressStream = _repositories.localRepository.fetchAddress();
    await for (final addressList in addressStream) {
      if (state.wallet.address.isEmpty) {
        emit(state.copyWith(
            wallet: state.wallet.copyWith(address: addressList)));
      } else {
        _syncBalance(appDataBloc.state.summaryBlock, address: addressList);
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

  void _fetchAddresses(event, emit) async {}

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

  Future<void> _syncBalance(List<SumaryData> summary,
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

    if (totalBalance != 0) {
      emit(state.copyWith(
          wallet: state.wallet
              .copyWith(address: listAddress, balanceTotal: totalBalance)));

      _walletUpdate.add(true);
    }
  }

  void _syncPendings(List<PendingTransaction> summary) async {
    double totalOutgoing = 0;
    double totalIncoming = 0;

    for (var address in state.wallet.address) {
      PendingTransaction? foundReceiver = summary.firstWhere(
          (other) => other.receiver == address.hash,
          orElse: () => PendingTransaction());
      PendingTransaction? foundSender = summary.firstWhere(
          (other) => other.sender == address.hash,
          orElse: () => PendingTransaction());

      if (foundReceiver.receiver.isNotEmpty) {
        totalIncoming += foundReceiver.amountTransfer;
        address.incoming = foundReceiver.amountTransfer;
      } else if (foundSender.sender.isNotEmpty) {
        var cell = foundSender.amountTransfer + foundSender.amountFee;
        totalOutgoing += cell;
        address.outgoing = cell;
      } else {
        address.incoming = 0;
        address.outgoing = 0;
      }
    }
    emit(state.copyWith(
        wallet: state.wallet.copyWith(
            address: state.wallet.address,
            totalIncoming: totalIncoming,
            totalOutgoing: totalOutgoing)));
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
    _summarySubscriptions.cancel();
    _pendingsSubscriptions.cancel();
    _walletUpdate.close();
    return super.close();
  }
}
