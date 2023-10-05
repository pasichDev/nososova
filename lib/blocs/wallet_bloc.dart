import 'package:bloc/bloc.dart';
import 'package:nososova/repositories/local_repository.dart';
import 'package:nososova/repositories/server_repository.dart';
import 'package:nososova/utils/noso/crypto.dart';

import '../database/database.dart';
import '../models/address_object.dart';
import '../models/app/wallet.dart';
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
  final NosoCrypto _nosoCrypto;
  final LocalRepository _localRepository;

  WalletBloc({
    required NosoCrypto nosoCrypto,
    required LocalRepository localRepository,
  })   : _nosoCrypto = nosoCrypto,
        _localRepository = localRepository,
        super(WalletState()) {
    on<FetchAddress>(_fetchAddresses);
    on<DeleteAddress>(_deleteAddress);
    on<AddAddress>(_addAddress);
    on<SyncBalance>(_syncBalance);
    on<CreateNewAddress>(_createNewAddress);
  }


  /// TODO Тут дуже крива реалізація, порібно переглянути
  void _createNewAddress(event, emit) async {
     AddressObject addressObject = _nosoCrypto.createNewAddress();
    var address = Address(
         publicKey: addressObject.publicKey.toString(),
        privateKey: addressObject.privateKey.toString(),
        hash: addressObject.hash.toString());

    await _localRepository.addWallet(address);
    final addressStream = _localRepository.fetchAddress();
    await for (final addressList in addressStream) {
      emit(state.copyWith(wallet: state.wallet.copyWith(address: addressList)));
    }
  }

  void _addAddress(event, emit) async {
    await _localRepository.addWallet(event.address);
    final addressStream = _localRepository.fetchAddress();
    await for (final addressList in addressStream) {
      emit(state.copyWith(wallet: state.wallet.copyWith(address: addressList)));
    }
  }

  void _deleteAddress(event, emit) async {
    await _localRepository.deleteWallet(event.address);
    final addressStream = _localRepository.fetchAddress();
    await for (final addressList in addressStream) {
      emit(state.copyWith(wallet: state.wallet.copyWith(address: addressList)));
    }
  }

  void _fetchAddresses(event, emit) async {
    final addressStream = _localRepository.fetchAddress();
    await for (final addressList in addressStream) {
      emit(state.copyWith(wallet: state.wallet.copyWith(address: addressList)));
    }
  }

  void _syncBalance(event, emit) async {}
}
