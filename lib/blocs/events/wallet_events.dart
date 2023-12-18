import 'package:file_picker/file_picker.dart';
import 'package:nososova/utils/noso/model/summary_data.dart';

import '../../utils/noso/model/address_object.dart';
import '../../utils/noso/model/pending_transaction.dart';

abstract class WalletEvent {}

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

class FetchHistoryAddress extends WalletEvent {
  final String value;

  FetchHistoryAddress(this.value);
}

class CleanDataAddress extends WalletEvent {}

class SetAlias extends WalletEvent {
  final String alias;
  final Address address;
  final int widgetId;

  SetAlias(this.alias, this.address, this.widgetId);
}

class CalculateBalance extends WalletEvent {
  final List<SumaryData> summaryData;
  final bool checkConsensus;

  CalculateBalance(this.summaryData, this.checkConsensus);
}
