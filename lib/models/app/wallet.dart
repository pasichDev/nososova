import '../../utils/noso/src/address_object.dart';

class Wallet {
  List<Address> address;
  double balanceTotal = 0;
  double totalOutgoing = 0;
  double totalIncoming = 0;

  Wallet(
      {this.address = const [],
      this.balanceTotal = 0,
      this.totalOutgoing = 0,
      this.totalIncoming = 0});

  Address? getAddress(String targetHash) {
    Address? foundAddress = address.firstWhere(
      (address) => address.hash == targetHash,
      orElse: () => Address(hash: '', publicKey: '', privateKey: ''),
    );

    if (foundAddress.hash.isEmpty) {
      return null;
    } else {
      return foundAddress;
    }
  }

  Wallet copyWith({
    List<Address>? address,
    double? balanceTotal,
    double? totalOutgoing,
    double? totalIncoming,
  }) {
    return Wallet(
      address: address ?? this.address,
      balanceTotal: balanceTotal ?? this.balanceTotal,
      totalOutgoing: totalOutgoing ?? this.totalOutgoing,
      totalIncoming: totalIncoming ?? this.totalIncoming,
    );
  }
}
