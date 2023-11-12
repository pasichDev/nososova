import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:nososova/blocs/app_data_bloc.dart';
import 'package:nososova/models/summary_data.dart';
import 'package:nososova/repositories/repositories.dart';

import '../models/app/import_wallet_response.dart';
import '../models/app/wallet.dart';
import '../utils/const/files_const.dart';
import '../utils/noso/src/address_object.dart';
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
  final StreamController<ImportWResponse> _actionsFileWallet =
      StreamController<ImportWResponse>.broadcast();

  Stream<ImportWResponse> get actionsFileWallet => _actionsFileWallet.stream;
  late StreamSubscription appBlockSubscription;

  WalletBloc({
    required Repositories repositories,
    required this.appDataBloc,
  })  : _repositories = repositories,
        super(WalletState()) {
    on<FetchAddress>(_fetchAddresses);
    on<DeleteAddress>(_deleteAddress);
    on<AddAddress>(_addAddress);
    //  on<SyncBalance>(_syncBalance);
    on<CreateNewAddress>(_createNewAddress);
    on<ImportWalletFile>(_importWalletFile);
    on<ImportWalletQr>(_importWalletQr);
    on<AddAddresses>(_addAddresses);

    appBlockSubscription = appDataBloc.dataSumaryStream.listen((data) {
      _syncBalance(data);
      print('Updated data in OtherBloc: ${data.length}');
    });
  }

  void _createNewAddress(event, emit) async {
    Address address = _repositories.nosoCore.createNewAddress();
    await _repositories.localRepository.addAddress(address);
  }

  void _addAddress(event, emit) async {
    await _repositories.localRepository.addAddress(event.address);
  }

  void _deleteAddress(event, emit) async {
    await _repositories.localRepository.deleteAddress(event.address);
  }

  void _fetchAddresses(event, emit) async {
    final addressStream = _repositories.localRepository.fetchAddress();
    await for (final addressList in addressStream) {
      emit(state.copyWith(wallet: state.wallet.copyWith(address: addressList)));
    }
  }

  void _addAddresses(event, emit) async {
    List<Address> listAddresses = event.addresses;
    await _repositories.localRepository.addAddresses(listAddresses);
    _actionsFileWallet.sink.add(ImportWResponse(
        actionsFileWallet: ActionsFileWallet.addressAdded,
        value: listAddresses.length.toString()));
  }

  void _syncBalance(List<SumaryData> summary) async {
    double totalBalance = 0;
    for (var address in state.wallet.address) {
      SumaryData found = summary.firstWhere(
          (other) => other.hash == address.hash,
          orElse: () => SumaryData());

      if (found.hash.isNotEmpty) {
        totalBalance += found.balance;
        address.balance = found.balance;
        address.lastOP = found.lastOP;
        address.score = found.score;
      }
    }
    if(totalBalance != 0) {
      emit(state.copyWith(
        wallet: state.wallet.copyWith(address: state.wallet.address, balanceTotal: totalBalance)));
    }
  }

  void _importWalletFile(event, emit) async {
    final FilePickerResult? result = event.filePickerResult;
    if (result != null) {
      var file = result.files.first;
      if (file.extension?.toLowerCase() == FilesConst.pkwExtensions) {
        var bytes =
            await _repositories.fileRepository.readBytesFromPlatformFile(file);
        var listAddress = _repositories.nosoCore.parseExternalWallet(bytes);

        if (listAddress.isNotEmpty) {
          _actionsFileWallet.sink.add(ImportWResponse(
              actionsFileWallet: ActionsFileWallet.walletOpen,
              address: listAddress));
        } else {
          _actionsFileWallet.sink.add(ImportWResponse(
              actionsFileWallet: ActionsFileWallet.isFileEmpty));
        }
      } else {
        _actionsFileWallet.sink.add(ImportWResponse(
            actionsFileWallet: ActionsFileWallet.fileNotSupported));
      }
    }
  }

  void _importWalletQr(event, emit) async {
    var address =
        _repositories.nosoCore.importAddressForKeysPair(event.addressKeys);

    if (address != null) {
      _actionsFileWallet.sink.add(ImportWResponse(
          actionsFileWallet: ActionsFileWallet.walletOpen, address: [address]));
    }
  }

  @override
  Future<void> close() {
    _actionsFileWallet.close();
    return super.close();
  }
}
