import '../../utils/noso/src/address_object.dart';
import '../pending_transaction.dart';

class Wallet {
  List<PendingTransaction> pendings; //delete
  List<Address> address;
  double balanceTotal = 0;
  double totalOutgoing = 0;
  double totalIncoming = 0;

  Wallet({
    this.pendings = const [],
    this.address = const [],
    this.balanceTotal = 0,
    this.totalOutgoing = 0,
    this.totalIncoming = 0
  });

  Wallet copyWith({
    List<PendingTransaction>? pendings,
    List<Address>? address,
    double? balanceTotal,
    double? totalOutgoing,
    double? totalIncoming,
  }) {
    return Wallet(
      pendings: pendings ?? this.pendings,
      address: address ?? this.address,
      balanceTotal: balanceTotal ?? this.balanceTotal,
      totalOutgoing: totalOutgoing ?? this.totalOutgoing,
      totalIncoming: totalIncoming ?? this.totalIncoming,
    );
  }
}
