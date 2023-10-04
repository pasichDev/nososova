import '../../database/database.dart';
import '../pending_transaction.dart';

class Wallet {
  List<PendingTransaction> pendings;
  List<Address> address;

  Wallet({
    this.pendings = const [],
    this.address = const [],
  });

  Wallet copyWith({
    List<PendingTransaction>? pendings,
    List<Address>? address,
  }) {
    return Wallet(
      pendings: pendings ?? this.pendings,
      address: address ?? this.address,
    );
  }
}

