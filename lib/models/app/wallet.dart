import 'package:nososova/utils/noso/model/pending_transaction.dart';
import 'package:nososova/utils/noso/model/summary_data.dart';

import '../../utils/const/network_const.dart';
import '../../utils/noso/model/address_object.dart';

class Wallet {
  List<Address> address;
  List<SumaryData> summary;
  List<PendingTransaction> pendings;
  double balanceTotal = 0;
  double totalOutgoing = 0;
  double totalIncoming = 0;
  ConsensusStatus consensusStatus;

  Wallet(
      {this.address = const [],
      this.summary = const [],
      this.pendings = const [],
      this.balanceTotal = 0,
      this.totalOutgoing = 0,
      this.consensusStatus = ConsensusStatus.error,
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

  Wallet copyWith(
      {List<Address>? address,
      List<SumaryData>? summary,
      List<PendingTransaction>? pendings,
      double? balanceTotal,
      double? totalOutgoing,
      double? totalIncoming,
      ConsensusStatus? consensusStatus}) {
    return Wallet(
      address: address ?? this.address,
      summary: summary ?? this.summary,
      pendings: pendings ?? this.pendings,
      balanceTotal: balanceTotal ?? this.balanceTotal,
      totalOutgoing: totalOutgoing ?? this.totalOutgoing,
      consensusStatus: consensusStatus ?? this.consensusStatus,
      totalIncoming: totalIncoming ?? this.totalIncoming,
    );
  }
}
