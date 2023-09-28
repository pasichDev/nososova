import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/blocs/wallet_bloc.dart';
import 'package:nososova/database/database.dart';
import 'package:nososova/pages/wallets/screens/dialogs/dialog_wallet_info.dart';
import 'package:nososova/pages/wallets/screens/item_wallet_tile.dart';

class ListWallets extends StatelessWidget {
  const ListWallets({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {

          final wallets = state.address;
          return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 0.0),
                  itemCount: wallets.length,
                  itemBuilder: (context, index) {
                    final address = wallets[index];
                    return AddressListTile(
                      address: address,
                      onButtonClick: () {
                        _showBottomSheet(context, address, BlocProvider.of<WalletBloc>(context));
                      },
                    );
                  }));

      },
    );
  }
}

void _showBottomSheet(BuildContext context, Address adr, WalletBloc dataBloc) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return AddressInfo(
        address: adr,
        walletBloc: dataBloc,
      );
    },
  );
}
