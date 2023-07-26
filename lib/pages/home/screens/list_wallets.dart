import 'package:flutter/material.dart';
import 'package:nososova/models/wallet_object.dart';
import 'package:nososova/pages/home/screens/dialogs/dialog_wallet_info.dart';
import 'package:nososova/pages/home/screens/item_wallet_tile.dart';

class ListWallets extends StatelessWidget {
  const ListWallets({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
        itemCount: 20,
        itemBuilder: (context, index) {
          return WalletListTile(
              wallet: WalletObject(hash: "N3bbDSazRM3AfKJ8st7jxDj8nuPjKEP", balance: 0),
              onButtonClick: () {
                _showBottomSheet(context, 'N3bbDSazRM3AfKJ8st7jxDj8nuPjKEP');
              });
        },
      ),
    );
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
