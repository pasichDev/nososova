import 'package:flutter/material.dart';
import 'package:nososova/database/database.dart';
import 'package:nososova/pages/app_state.dart';
import 'package:nososova/pages/wallets/screens/dialogs/dialog_wallet_info.dart';
import 'package:nososova/pages/wallets/screens/item_wallet_tile.dart';
import 'package:provider/provider.dart';

class ListWallets extends StatelessWidget {
  const ListWallets({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
      child: Consumer<AppState>(builder: (context, appState, _) {
        return FutureBuilder<List<Address>>(
          future: appState.fetchDataWallets(),
          builder: (context, snapshot) {
           /* if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else*/ if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No wallets available.');
            } else {
              final wallets = snapshot.data!;

              return ListView.builder(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                itemCount: wallets.length,
                itemBuilder: (context, index) {
                  final address = wallets[index];
                  return AddressListTile(
                    address: address,
                    onButtonClick: () {
                      _showBottomSheet(context, address);
                    },
                  );
                },
              );
            }
          },
        );
      }),
    );
  }
}

void _showBottomSheet(BuildContext context, Address adr) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return AddressInfo(
        address: adr,
      );
    },
  );
}
