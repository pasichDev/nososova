import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/blocs/wallet_bloc.dart';

import '../../../tiles/tile_wallet_address.dart';
import 'dialogs/dialog_address_info.dart';

class ListAddresses extends StatelessWidget {
  const ListAddresses({super.key});

  @override
  Widget build(BuildContext context) {
    /*
    var  walletBloc = BlocProvider.of<WalletBloc>(context);
    return StreamBuilder<List<AddressObject>>(
      stream: walletBloc.dataStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<AddressObject> data = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            padding:
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            itemBuilder: (context, index) {
             return AddressListTile(
                address: data[index],
                onButtonClick: () {
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20.0)),
                      ),
                      context: context,
                      builder: (_) => BlocProvider.value(
                          value: BlocProvider.of<WalletBloc>(context),
                          child: AddressInfo(
                            address: data[index],
                          )));
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Помилка: ${snapshot.error}');
        }
        return CircularProgressIndicator(); // Показувати прогрес, якщо дані ще завантажуються
      },
    );


     */

    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        final wallets = state.wallet.address;
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
                          builder: (_) => BlocProvider.value(
                              value: BlocProvider.of<WalletBloc>(context),
                              child: AddressInfo(
                                address: address,
                              )));
                    },
                  );
                }));
      },
    );
  }
}
