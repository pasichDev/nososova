import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/blocs/wallet_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../common/components/empty_list_widget.dart';
import '../../../tiles/tile_node_address.dart';

class ListNodes extends StatelessWidget {
  const ListNodes({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        final nodes = state.stateNodes.nodes;
        if (nodes.isEmpty) {
          return Expanded(
              flex: 2,
              child:Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            color: Colors.white,
            child: Center(
                child: EmptyWidget(
                    title: AppLocalizations.of(context)!.empty,
                    descrpt: AppLocalizations.of(context)!.emptyNodesError)),
          ));
        } else {
          return  ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0.0, vertical: 0.0),
                  itemCount: nodes.length,
                  itemBuilder: (context, index) {
                    return AddressNodeTile(
                      address: nodes[index],
                    );
                  });
        }
      },
    );
  }
}
