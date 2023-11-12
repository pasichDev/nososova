import '../../utils/noso/src/address_object.dart';
import '../pending_transaction.dart';

class Wallet {
  List<PendingTransaction> pendings; //delete
  List<Address> address;
  double balanceTotal = 0;

  Wallet({
    this.pendings = const [],
    this.address = const [],
    this.balanceTotal = 0
  });

  Wallet copyWith({
    List<PendingTransaction>? pendings,
    List<Address>? address,
    double? balanceTotal,
  }) {
    return Wallet(
      pendings: pendings ?? this.pendings,
      address: address ?? this.address,
      balanceTotal: balanceTotal ?? this.balanceTotal,
    );
  }
}
