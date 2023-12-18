import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:nososova/blocs/app_data_bloc.dart';
import 'package:nososova/blocs/wallet_bloc.dart';
import 'package:nososova/models/app/state_node.dart';
import 'package:nososova/repositories/repositories.dart';
import 'package:nososova/utils/noso/model/address_object.dart';

import '../utils/noso/utils.dart';
import 'events/node_events.dart';

class NodeState {
  final StateNode stateNode;

  NodeState({
    StateNode? stateNode,
  }) : stateNode = stateNode ?? StateNode();

  NodeState copyWith({
    StateNode? stateNode,
  }) {
    return NodeState(
      stateNode: stateNode ?? this.stateNode,
    );
  }
}

class NodeBloc extends Bloc<NodeEvent, NodeState> {
  final AppDataBloc appDataBloc;
  final WalletBloc walletBloc;
  final Repositories _repositories;
  late StreamSubscription _walletUpdate;

  NodeBloc({
    required Repositories repositories,
    required this.appDataBloc,
    required this.walletBloc,
  })  : _repositories = repositories,
        super(NodeState()) {
    _walletUpdate = walletBloc.walletUpdate.listen((data) {
      fetchStats();
    });
  }

  fetchStats() {
    var listAddresses = walletBloc.state.wallet.address;
    var listNodesPeople = appDataBloc.state.listPeopleNodes;
    List<Address> listUserNodes = [];
    bool containsSeedWallet(String wallet) =>
        listNodesPeople.any((address) => wallet == address.address);

    for (Address address in listAddresses) {
      if (address.balance >= UtilsDataNoso.getCountMonetToRunNode()) {
        address.nodeAvailable = true;
        address.nodeStatusOn = containsSeedWallet(address.hash);
        listUserNodes.add(address);
      }
    }
   // double blockReward = appDataBloc.state.statsInfoCoin.blockInfo.reward;
    var launched =
        listUserNodes.where((item) => item.nodeStatusOn == true).length;
    var nodesReward = 0 * launched;
    emit(state.copyWith(
        stateNode: state.stateNode.copyWith(
            nodes: listUserNodes,
            rewardDay: 0,
            launchedNodes: launched)));
  }

  @override
  Future<void> close() {
    _walletUpdate.cancel();
    return super.close();
  }
}
