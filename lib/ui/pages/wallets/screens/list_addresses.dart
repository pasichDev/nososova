import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/blocs/wallet_bloc.dart';

import '../../../theme/style/dialog_style.dart';
import '../../../tiles/tile_wallet_address.dart';
import 'dialogs/dialog_address_info.dart';

class ListAddresses extends StatelessWidget {
  const ListAddresses({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        final wallets = state.wallet.address;
        return Expanded(
            child: SingleChildScrollView(
                child: Column(children: [
          ListView.builder(
              shrinkWrap: true,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              itemCount: wallets.length,
              itemBuilder: (context, index) {
                final address = wallets[index];
                return AddressListTile(
                  address: address,
                  onButtonClick: () {
                    showModalBottomSheet(
                        shape: DialogStyle.borderShape,
                        context: context,
                        builder: (_) => BlocProvider.value(
                            value: BlocProvider.of<WalletBloc>(context),
                            child: AddressInfo(
                              address: address,
                            )));
                  },
                );
              })
        ])));
      },
    );
  }
}
