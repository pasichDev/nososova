import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/blocs/wallet_bloc.dart';

import 'dialogs/dialog_address_info.dart';
import '../../../tiles/tile_wallet_address.dart';

class ListWallets extends StatelessWidget {
  const ListWallets({super.key});

  @override
  Widget build(BuildContext context) {
    var walletBloc = BlocProvider.of<WalletBloc>(context);
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        final wallets = state.address;
        return Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: ListView.builder(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                itemCount: wallets.length,
                itemBuilder: (context, index) {
                  final address = wallets[index];
                  return AddressListTile(
                    address: address,
                    onButtonClick: () {
                      showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20.0)),
                          ),
                          context: context,
                          builder: (BuildContext context) =>
                              //   BlocProvider.value(value: BlocProvider.of<WalletBloc>(context), child:
                              AddressInfo(
                                address: address,
                                walletBloc: walletBloc,
                              ));
                      //) ,) ;
                    },
                  );
                }));
      },
    );
  }
}
