import 'package:bloc/bloc.dart';
import 'package:nososova/database/database.dart';
import 'package:nososova/repositories/local_repository.dart';
import 'package:nososova/repositories/server_repository.dart';

import '../models/app/wallet.dart';
import '../models/pending_transaction.dart';

abstract class WalletEvent {}

class FetchAddress extends WalletEvent {}

class SyncBalance extends WalletEvent {
  final List<PendingTransaction> pendings;

  SyncBalance(this.pendings);
}

class DeleteAddress extends WalletEvent {
  final Address address;

  DeleteAddress(this.address);
}

class AddAddress extends WalletEvent {
  final Address address;

  AddAddress(this.address);
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
  final ServerRepository serverRepository;
  final LocalRepository localRepository;

  WalletBloc({required this.serverRepository, required this.localRepository})
      : super(WalletState()) {
    on<FetchAddress>(_fetchAddresses);
    on<DeleteAddress>(_deleteAddress);
    on<AddAddress>(_addAddress);
    on<SyncBalance>(_syncBalance);
  }

  void _addAddress(event, emit) async {
    await localRepository.addWallet(event.address);
    final addressStream = localRepository.fetchAddress();
    await for (final addressList in addressStream) {
      emit(state.copyWith(wallet: state.wallet.copyWith(address: addressList)));
    }
  }

  void _deleteAddress(event, emit) async {
    await localRepository.deleteWallet(event.address);
    final addressStream = localRepository.fetchAddress();
    await for (final addressList in addressStream) {
      emit(state.copyWith(wallet: state.wallet.copyWith(address: addressList)));
    }
  }

  void _fetchAddresses(event, emit) async {
    final addressStream = localRepository.fetchAddress();
    await for (final addressList in addressStream) {
      emit(state.copyWith(wallet: state.wallet.copyWith(address: addressList)));
    }
  }

  void _syncBalance(event, emit) async {}
}
