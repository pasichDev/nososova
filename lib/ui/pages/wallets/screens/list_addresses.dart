import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/blocs/wallet_bloc.dart';
import 'package:nososova/ui/route/dialog_router.dart';
import 'package:nososova/ui/route/page_router.dart';

import '../../../tiles/tile_wallet_address.dart';

class ListAddresses extends StatelessWidget {
  const ListAddresses({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        final wallets = state.wallet.address;
        return Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                itemCount: wallets.length,
                itemBuilder: (_, index) {
                  final address = wallets[index];
                  return AddressListTile(
                    address: address,
                    onTap: () =>
                        PageRouter.routeAddressInfoPage(context, address),
                    onLong: () =>
                        DialogRouter.showDialogAddressActions(context, address),
                  );
                }));
      },
    );
  }
}
