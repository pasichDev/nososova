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
    on<FetchAddress>((event, emit) async {
      final addressStream = localRepository.fetchAddress();
      await for (final addressList in addressStream) {
        emit(WalletState(address: addressList));
      }
    });

    on<DeleteAddress>((event, emit) async {
      await localRepository.deleteWallet(event.address);
      final addressStream = localRepository.fetchAddress();
      await for (final addressList in addressStream) {
        emit(WalletState(address: addressList));
      }
    });

    on<AddAddress>((event, emit) async {
      // Викликаємо метод для додавання гаманця і оновлюємо стан
      await localRepository.addWallet(event.address);
      final addressStream = localRepository.fetchAddress();
      await for (final addressList in addressStream) {
        emit(WalletState(address: addressList));
      }
    });
  }
}
