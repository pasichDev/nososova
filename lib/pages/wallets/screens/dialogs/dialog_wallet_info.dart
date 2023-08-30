import 'package:flutter/material.dart';
import 'package:nososova/database/database.dart';
import 'package:nososova/pages/app_state.dart';
import 'package:nososova/pages/components/item_dialog.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class WalletInfo extends StatelessWidget {
  final Wallet wallet;

  const WalletInfo({Key? key, required this.wallet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: QrImageView(
            data: wallet.hash,
            version: QrVersions.auto,
            size: 200.0,
          )),
      Text(
        wallet.hash,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      const SizedBox(height: 16),
      ListView(
        shrinkWrap: true,
        children: [
          buildListItem(Icons.delete, 'Delete', () {
            appState.deleteWallet(wallet);
            Navigator.pop(context);
          }),
          buildListItem(Icons.send_rounded, 'Send from this address', () {}),
        ],
      ),
    ]);
  }
}
