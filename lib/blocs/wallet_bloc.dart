import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:nososova/repositories/repositories.dart';

import '../database/database.dart';
import '../models/address_object.dart';
import '../models/app/wallet.dart';
import '../utils/const/files_const.dart';
import '../utils/noso/parse.dart';
import 'events/wallet_events.dart';

class SnackbarShownState extends WalletState {
  final String message;

  SnackbarShownState(this.message);
}
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
  WalletBloc({
    required Repositories repositories,
  })   : _repositories = repositories,
        super(WalletState()) {
    on<FetchAddress>(_fetchAddresses);
    on<DeleteAddress>(_deleteAddress);
    on<AddAddress>(_addAddress);
    on<SyncBalance>(_syncBalance);
    on<CreateNewAddress>(_createNewAddress);
  }


  /// TODO Тут дуже крива реалізація, порібно переглянути
  void _createNewAddress(event, emit) async {
     AddressObject addressObject = _repositories.nosoCrypto.createNewAddress();
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
    final addressStream =_repositories.localRepository.fetchAddress();
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

  void _syncBalance(event, emit) async {}


  void _importWalletFile(FilePickerResult result) async {

    if (result != null) {
      var file = result.files.first;
      if (file.extension?.toLowerCase() == FilesConst.pkwExtensions) {
        var bytes = await _repositories.fileRepository.readBytesFromPlatformFile(file);
        var listAddress = NosoParse.parseExternalWallet(bytes);

        if (listAddress.isNotEmpty) {
          // Виконайте дії, які стосуються успішного імпорту
        } else {
          // Відправте подію в BLoC, щоб відобразити Snackbar з відповідним повідомленням
      //    MyBlocEvent.showErrorSnackbar('Це файл не має записаних адрес');
        }
      } else {
        // Відправте подію в BLoC, щоб відобразити Snackbar з повідомленням про непідтримуване розширення
     //   MyBlocEvent.showErrorSnackbar('Цей файл не підтримується');
      }
    }
  }
}
