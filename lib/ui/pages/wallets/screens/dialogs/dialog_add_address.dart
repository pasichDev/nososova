import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nososova/blocs/wallet_bloc.dart';
import 'package:nososova/database/database.dart';
import 'package:nososova/l10n/app_localizations.dart';
import 'package:nososova/models/address_object.dart';
import 'package:nososova/ui/tiles/dialog_tile.dart';
import 'package:nososova/utils/noso/cripto.dart';

import '../../../../theme/style/text_style.dart';
import '../../../qrscanner/qr_scan_page.dart';


class DialogAddAddress extends StatelessWidget {
  final WalletBloc walletBloc;

  const DialogAddAddress({required this.walletBloc, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      ListView(
        shrinkWrap: true,
        children: [
          ListTile(
              title: Text(AppLocalizations.of(context)!.newTitle,
                  style: AppTextStyles.dialogTitle)),
          buildListTile(Icons.add, AppLocalizations.of(context)!.genNewKeyPair,
              () {
            Address? wallet = _generateKeysPair();
            if (wallet != null) {
              walletBloc.add(AddAddress(wallet));
            }
            Navigator.pop(context);
          }),
          ListTile(
              title: Text(AppLocalizations.of(context)!.import,
                  style: AppTextStyles.dialogTitle)),
          if (Platform.isAndroid || Platform.isIOS)
            buildListTile(
                Icons.qr_code,
                AppLocalizations.of(context)!.scanQrCode,
                () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const QRScanScreen()),
                    )),
          buildListTile(Icons.file_copy_outlined,
              AppLocalizations.of(context)!.selectFilePkw, () {}),
          ListTile(
              title: Text(AppLocalizations.of(context)!.export,
                  style: AppTextStyles.dialogTitle)),
          buildListTile(Icons.file_copy_outlined,
              AppLocalizations.of(context)!.saveFilePkw, () {}),
          const SizedBox(height: 10)
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
