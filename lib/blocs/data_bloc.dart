import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:nososova/database/database.dart';
import 'package:nososova/repositories/local_repository.dart';
import 'package:nososova/repositories/server_repository.dart';

/// Данні які доступні по всіх фрагментах
abstract class DataEvent {}

class FetchAddress extends DataEvent {}

class DeleteWallet extends DataEvent {
  final Address address;

  DeleteWallet(this.address);
}

class AddWallet extends DataEvent {
  final Address address;

  AddWallet(this.address);
}

class DataState {
  final List<Address> address;

  DataState({required this.address});
}

class DataBloc extends Bloc<DataEvent, DataState> {
  final ServerRepository serverRepository;
  final LocalRepository localRepository;

  DataBloc({required this.serverRepository, required this.localRepository})
      : super(DataState(address: [])) {
    on<FetchAddress>((event, emit) async {
      final addressStream = localRepository.fetchAddress();
      await for (final addressList in addressStream) {
        emit(DataState(address: addressList));
      }
    });

    on<DeleteWallet>((event, emit) async {
      await localRepository.deleteWallet(event.address);
      final addressStream = localRepository.fetchAddress();
      await for (final addressList in addressStream) {
        emit(DataState(address: addressList));
      }
    });

    on<AddWallet>((event, emit) async {
      // Викликаємо метод для додавання гаманця і оновлюємо стан
      await localRepository.addWallet(event.address);
      final addressStream = localRepository.fetchAddress();
      await for (final addressList in addressStream) {
        emit(DataState(address: addressList));
      }
    });

  }

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    // Тут не потрібно нічого додавати, так як обробка подій відбувається в обробниках on<...>
  }
}
