import 'package:bloc/bloc.dart';
import 'package:nososova/database/database.dart';
import 'package:nososova/repositories/local_repository.dart';
import 'package:nososova/repositories/server_repository.dart';

abstract class WalletEvent {}

class FetchAddress extends WalletEvent {}

class DeleteAddress extends WalletEvent {
  final Address address;

  DeleteAddress(this.address);
}

class AddAddress extends WalletEvent {
  final Address address;

  AddAddress(this.address);
}

class WalletState {
  final List<Address> address;

  WalletState({required this.address});
}

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final ServerRepository serverRepository;
  final LocalRepository localRepository;

  WalletBloc({required this.serverRepository, required this.localRepository})
      : super(WalletState(address: [])) {
    on<FetchAddress>(_fetchAddresses);
    on<DeleteAddress>(_deleteAddress);
    on<AddAddress>(_addAddress);
  }

  void _addAddress(event, emit) async {
    await localRepository.addWallet(event.address);
    final addressStream = localRepository.fetchAddress();
    await for (final addressList in addressStream) {
      emit(WalletState(address: addressList));
    }
  }

  void _deleteAddress(event, emit) async {
    await localRepository.deleteWallet(event.address);
    final addressStream = localRepository.fetchAddress();
    await for (final addressList in addressStream) {
      emit(WalletState(address: addressList));
    }
  }

  void _fetchAddresses(event, emit) async {
    final addressStream = localRepository.fetchAddress();
    await for (final addressList in addressStream) {
      emit(WalletState(address: addressList));
    }
  }
}
