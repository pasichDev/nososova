import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:nososova/repositories/repositories.dart';

import '../database/database.dart';
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
  final Repositories _repositories;
  final StreamController<ImportWResponse> _actionsFileWallet =
      StreamController<ImportWResponse>.broadcast();

  Stream<ImportWResponse> get actionsFileWallet => _actionsFileWallet.stream;

  WalletBloc({
    required Repositories repositories,
  })  : _repositories = repositories,
        super(WalletState()) {
    on<FetchAddress>(_fetchAddresses);
    on<DeleteAddress>(_deleteAddress);
    on<AddAddress>(_addAddress);
    on<SyncBalance>(_syncBalance);
    on<CreateNewAddress>(_createNewAddress);
    on<ImportWalletFile>(_importWalletFile);
    on<AddAddresses>(_addAddresses);
  }

  /// TODO Тут дуже крива реалізація, порібно переглянути
  void _createNewAddress(event, emit) async {
    AddressObject addressObject = _repositories.nosoCore.createNewAddress();
    var address = Address(
        publicKey: addressObject.publicKey.toString(),
        privateKey: addressObject.privateKey.toString(),
        hash: addressObject.hash.toString());

    await _repositories.localRepository.addWallet(address);
    final addressStream = _repositories.localRepository.fetchAddress();
    await for (final addressList in addressStream) {
      emit(state.copyWith(wallet: state.wallet.copyWith(address: addressList)));
    }
  }

  void _addAddress(event, emit) async {
    await _repositories.localRepository.addWallet(event.address);
    final addressStream = _repositories.localRepository.fetchAddress();
    await for (final addressList in addressStream) {
      emit(state.copyWith(wallet: state.wallet.copyWith(address: addressList)));
    }
  }

  void _deleteAddress(event, emit) async {
    await _repositories.localRepository.deleteWallet(event.address);
    final addressStream = _repositories.localRepository.fetchAddress();
    await for (final addressList in addressStream) {
      emit(state.copyWith(wallet: state.wallet.copyWith(address: addressList)));
    }
  }

  void _fetchAddresses(event, emit) async {
    final addressStream = _repositories.localRepository.fetchAddress();
    await for (final addressList in addressStream) {
      emit(state.copyWith(wallet: state.wallet.copyWith(address: addressList)));
    }
  }

  /// TODO Додати верифікацію ключів в метод _importWalletFile, саме під час доавання адрес в список який ми отримаємо тут
  void _addAddresses(event, emit) async {
   /* await _repositories.localRepository.addWallet(event.address);
    final addressStream = _repositories.localRepository.fetchAddress();
    await for (final addressList in addressStream) {
      emit(state.copyWith(wallet: state.wallet.copyWith(address: addressList)));
    }

    */
  }

  void _syncBalance(event, emit) async {}

  void _importWalletFile(event, emit) async {
    final FilePickerResult? result = event.filePickerResult;
    if (result != null) {
      var file = result.files.first;
      if (file.extension?.toLowerCase() == FilesConst.pkwExtensions) {
        var bytes = await _repositories.fileRepository.readBytesFromPlatformFile(file);
        var listAddress = _repositories.nosoCore.parseExternalWallet(bytes);

        if (listAddress.isNotEmpty) {
          _actionsFileWallet.sink.add(ImportWResponse(actionsFileWallet:ActionsFileWallet.walletOpen, address: listAddress));
        } else {
          _actionsFileWallet.sink.add(ImportWResponse(actionsFileWallet:ActionsFileWallet.isFileEmpty));
        }
      } else {
        _actionsFileWallet.sink.add(ImportWResponse(actionsFileWallet:ActionsFileWallet.fileNotSupported));
      }
    }
  }

  @override
  Future<void> close() {
    _actionsFileWallet.close();
    return super.close();
  }
}
