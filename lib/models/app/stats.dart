import '../block_mns.dart';

class StatsInfoCoin {
  int totalCoin = 0;
  int totalNodesPeople = 0;
  BlockMNS_RPC blockInfo;

  StatsInfoCoin({
    this.totalCoin = 0,
    this.totalNodesPeople = 0,
    required this.blockInfo,
  });

  StatsInfoCoin copyWith({
    int? totalCoin,
    int? totalNodesPeople,
    BlockMNS_RPC? blockInfo,
  }) {
    return StatsInfoCoin(
      totalCoin: totalCoin ?? this.totalCoin,
      totalNodesPeople: totalNodesPeople ?? this.totalNodesPeople,
      blockInfo: blockInfo ?? this.blockInfo,
    );
  }
}
