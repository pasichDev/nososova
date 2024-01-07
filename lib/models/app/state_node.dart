import '../../models/address_wallet.dart';

class StateNodes {
  List<Address> nodes;
  int launchedNodes = 0;
  double rewardDay = 0;

  StateNodes({
    this.nodes = const [],
    this.launchedNodes = 0,
    this.rewardDay = 0,
  });

  StateNodes copyWith({
    List<Address>? nodes,
    int? launchedNodes,
    double? rewardDay,
  }) {
    return StateNodes(
      nodes: nodes ?? this.nodes,
      launchedNodes: launchedNodes ?? this.launchedNodes,
      rewardDay: rewardDay ?? this.rewardDay,
    );
  }
}
