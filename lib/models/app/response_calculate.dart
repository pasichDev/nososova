import '../../models/address_wallet.dart';

class ResponseCalculate {
  List<Address>? address;
  double totalOutgoing;
  double totalIncoming;
  double totalBalance;

  ResponseCalculate({
    this.address,
    this.totalOutgoing = 0,
    this.totalIncoming = 0,
    this.totalBalance = 0,
  });

  ResponseCalculate copyWith({
    List<Address>? address,
    double? totalOutgoing,
    double? totalIncoming,
    double? totalBalance,
  }) {
    return ResponseCalculate(
      address: address ?? this.address,
      totalOutgoing: totalOutgoing ?? this.totalOutgoing,
      totalIncoming: totalIncoming ?? this.totalIncoming,
      totalBalance: totalBalance ?? this.totalBalance,
    );
  }
}
