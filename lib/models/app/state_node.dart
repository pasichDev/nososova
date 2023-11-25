import '../../utils/noso/src/address_object.dart';

class StateNode {
  List<Address> nodes;
  int launchedNodes = 0;
  double rewardDay = 0;

  StateNode({
    this.nodes = const [],
    this.launchedNodes = 0,
    this.rewardDay = 0,
  });

  StateNode copyWith({
    List<Address>? nodes,
    int? launchedNodes,
    double? rewardDay,
  }) {
    return StateNode(
      nodes: nodes ?? this.nodes,
      launchedNodes: launchedNodes ?? this.launchedNodes,
      rewardDay: rewardDay ?? this.rewardDay,
    );
  }
}
