import 'package:file_picker/file_picker.dart';

import '../../models/pending_transaction.dart';
import '../../utils/noso/src/address_object.dart';

abstract class WalletEvent {}

/// Event to request all addresses from the local database
class FetchAddress extends WalletEvent {}

/// Event for synchronizing the balance
class SyncBalance extends WalletEvent {
  final List<PendingTransaction> pendings;

  SyncBalance(this.pendings);
}

/// Event that deletes an address from the wallet
class DeleteAddress extends WalletEvent {
  final Address address;

  DeleteAddress(this.address);
}

/// Event that adds an address to the wallet
class AddAddress extends WalletEvent {
  final Address address;

  AddAddress(this.address);
}

/// Event that adds an address to the wallet
class AddAddresses extends WalletEvent {
  final List<Address> addresses;

  AddAddresses(this.addresses);
}

/// Event that generates new addresses
class CreateNewAddress extends WalletEvent {
  CreateNewAddress();
}

/// Event that passes a wallet file for further parsing
class ImportWalletFile extends WalletEvent {
  final FilePickerResult? filePickerResult;

  ImportWalletFile(this.filePickerResult);
}

class ImportWalletQr extends WalletEvent {
  final String? addressKeys;

  ImportWalletQr(this.addressKeys);
}

//TERM DELRTE
class SendOrder extends WalletEvent {
  final String value;
  SendOrder(this.value);
}
