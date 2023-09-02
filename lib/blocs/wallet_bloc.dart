
/*
// Події та стан для фрагмента 1
abstract class WalletEvent {}

class LoadWalletDataEvent extends WalletEvent {}

class WalletState {
 // final List<ServerData> serverData;

//  WalletState({required this.serverData});
}

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final DataBloc dataBloc;

  WalletBloc({required this.dataBloc}) : super(WalletState(serverData: []));

  @override
  Stream<WalletState> mapEventToState(WalletEvent event) async* {
    if (event is LoadWalletDataEvent) {
   //   final serverData = dataBloc.state.serverData;
    //  yield WalletState(serverData: serverData);
    }
  }
}

 */
