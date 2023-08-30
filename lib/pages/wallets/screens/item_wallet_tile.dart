import 'package:flutter/material.dart';
import 'package:nososova/database/database.dart';

class WalletListTile extends StatelessWidget {
  final VoidCallback onButtonClick;
  final Wallet wallet;
  const WalletListTile(
      {super.key,
      required this.wallet,
      required this.onButtonClick});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.wallet),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(wallet.hash.toString()),
         /* Text(
            wallet.balance.toString() + ' noso',
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),

          */
        ],
      ),
      onTap: onButtonClick,
    );
  }
}
