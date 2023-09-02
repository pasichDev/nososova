import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:nososova/blocs/data_bloc.dart';
import 'package:nososova/database/database.dart';

abstract class WalletEvent {}

class FetchAllAddress extends WalletEvent {}

class WalletState {
  final List<Address> address;

 WalletState({required this.address});
}

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final DataBloc dataBloc;

  WalletBloc({required this.dataBloc}) : super(WalletState(address: [])){
    /*  on<FetchAllAddress>((event, emit) async {
    StreamSubscription<List<Address>>? subscription;
      subscription = dataBloc.localRepository.fetchAddress().listen((addressList) {

      });
      

    });

      */
    
  }

  @override
  Stream<WalletState> mapEventToState(WalletEvent event) async* {

  }
}


