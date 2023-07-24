import 'package:flutter/material.dart';
import 'package:nososova/pages/components/item_dialog.dart';
import 'package:qr_flutter/qr_flutter.dart';

class WalletInfo extends StatelessWidget {
  final String walletAddress;

  const WalletInfo({Key? key, required this.walletAddress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: QrImageView(
            data: walletAddress,
            version: QrVersions.auto,
            size: 200.0,
          )),
      Text(
        walletAddress,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      const SizedBox(height: 16),
      ListView(
        shrinkWrap: true,
        children: [
          buildListItem(Icons.delete, 'Delete', 'Home Screen', () {}),
          buildListItem(Icons.send_rounded, 'Send from this address',
              'Home Screen', () {}),
        ],
      ),
    ]);
  }
}
