import 'package:flutter/material.dart';
import 'package:nososova/database/database.dart';
import 'package:nososova/pages/wallets/screens/dialogs/dialog_wallet_info.dart';
import 'package:nososova/pages/wallets/screens/item_wallet_tile.dart';

class ListWallets extends StatelessWidget {
  ListWallets({super.key});

  final MyDatabase database = MyDatabase();
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
        child: FutureBuilder<List<Wallet>>(
          future: database.select(database.wallets).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return  const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
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
                  final wallet = wallets[index];
                  return WalletListTile(
                    wallet: wallet,
                    onButtonClick: () {
                      _showBottomSheet(context, wallet.hash);
                    },
                  );
                },
              );
            }
          },
        ));
  }
}

void _showBottomSheet(BuildContext context, String address) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return WalletInfo(
        walletAddress: address,
      );
    },
  );
}
