import 'package:flutter/material.dart';
import 'package:nososova/database/database.dart';
import 'package:nososova/models/wallet_object.dart';
import 'package:nososova/noso/cripto.dart';
import 'package:nososova/pages/components/item_dialog.dart';
import 'package:nososova/pages/qr_scan_page.dart';

class DialogAddWallet extends StatelessWidget {
  DialogAddWallet({super.key});

  final MyDatabase database = MyDatabase();
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      ListView(
        shrinkWrap: true,
        children: [
          const ListTile(
              title: Text("New",
                  style:
                      TextStyle(fontSize: 20.00, fontWeight: FontWeight.bold))),
          buildListItem(Icons.add, 'Generate new pair keys', () {
            Wallet? wallet = _generateKeysPair();
            if (wallet != null) {
              database.addWallet(wallet);
            }
            Navigator.pop(context);
          }),
          const ListTile(
              title: Text("Import",
                  style:
                      TextStyle(fontSize: 20.00, fontWeight: FontWeight.bold))),
          buildListItem(
              Icons.qr_code,
              'Scan QR Code',
              () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const QRScanScreen()),
                  )),
          buildListItem(Icons.file_copy_outlined, 'Selected file .pkw', () {}),
          const ListTile(
              title: Text("Export",
                  style:
                      TextStyle(fontSize: 20.00, fontWeight: FontWeight.bold))),
          buildListItem(Icons.file_copy_outlined, 'Save to file .pkw', () {}),
        ],
      ),
    ]);
  }

  Wallet? _generateKeysPair() {
    NosoCripto cripto = NosoCripto();
    WalletObject? walletObject = cripto.createNewAddress();

    if (walletObject == null) {
      return null;
    }

    return Wallet(
        publicKey: walletObject.publicKey.toString(),
        privateKey: walletObject.privateKey.toString(),
        hash: walletObject.hash.toString());
  }
}
