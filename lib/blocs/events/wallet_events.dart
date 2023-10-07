
import '../../database/database.dart';
import '../../models/pending_transaction.dart';
import '../wallet_bloc.dart';

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


class CreateNewAddress extends WalletEvent {

  CreateNewAddress();
}

class ImportWalletFile extends WalletEvent {
  final String message;

  ImportWalletFile(this.message);
}