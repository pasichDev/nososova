import 'package:flutter/material.dart';

class WalletListTile extends StatelessWidget {
  final VoidCallback onButtonClick;
  final String walletAddress;
  final double coins;
  const WalletListTile(
      {super.key,
      required this.walletAddress,
      required this.coins,
      required this.onButtonClick});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.wallet),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(walletAddress),
          Text(
            '$coins noso',
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      onTap: onButtonClick,
    );
  }
}
