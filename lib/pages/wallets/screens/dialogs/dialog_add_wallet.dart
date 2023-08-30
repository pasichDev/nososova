import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nososova/database/database.dart';
import 'package:nososova/database/models/address_object.dart';
import 'package:nososova/l10n/app_localizations.dart';
import 'package:nososova/noso/cripto.dart';
import 'package:nososova/pages/app_state.dart';
import 'package:nososova/pages/components/item_dialog.dart';
import 'package:nososova/pages/qr_scan_page.dart';
import 'package:provider/provider.dart';

class DialogAddAdress extends StatelessWidget {
  const DialogAddAdress({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Column(mainAxisSize: MainAxisSize.min, children: [
      ListView(
        shrinkWrap: true,
        children: [
          ListTile(
              title: Text(AppLocalizations.of(context)!.newTitle,
                  style: const TextStyle(
                      fontSize: 20.00, fontWeight: FontWeight.bold))),
          buildListItem(Icons.add, AppLocalizations.of(context)!.genNewKeyPair,
              () {
            Address? wallet = _generateKeysPair();
            if (wallet != null) {
              appState.addWallet(wallet);
            }
            Navigator.pop(context);
          }),
          ListTile(
              title: Text(AppLocalizations.of(context)!.import,
                  style: const TextStyle(
                      fontSize: 20.00, fontWeight: FontWeight.bold))),
          if (Platform.isAndroid || Platform.isIOS)
            buildListItem(
                Icons.qr_code,
                AppLocalizations.of(context)!.scanQrCode,
                () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const QRScanScreen()),
                    )),
          buildListItem(Icons.file_copy_outlined,
              AppLocalizations.of(context)!.selectFilePkw, () {}),
          ListTile(
              title: Text(AppLocalizations.of(context)!.export,
                  style: const TextStyle(
                      fontSize: 20.00, fontWeight: FontWeight.bold))),
          buildListItem(Icons.file_copy_outlined,
              AppLocalizations.of(context)!.saveFilePkw, () {}),
        ],
      ),
    ]);
  }

  Address? _generateKeysPair() {
    NosoCripto cripto = NosoCripto();
    AddressObject? addressObject = cripto.createNewAddress();

    if (addressObject == null) {
      return null;
    }

    return Address(
        publicKey: addressObject.publicKey.toString(),
        privateKey: addressObject.privateKey.toString(),
        hash: addressObject.hash.toString());
  }
}
