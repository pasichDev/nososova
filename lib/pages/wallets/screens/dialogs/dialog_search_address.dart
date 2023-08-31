import 'package:flutter/material.dart';
import 'package:nososova/database/database.dart';
import 'package:nososova/l10n/app_localizations.dart';
import 'package:nososova/pages/wallets/screens/item_wallet_tile.dart';
import 'package:nososova/utils/colors.dart';

class DialogSearchAddress extends StatelessWidget {
  const DialogSearchAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            AppLocalizations.of(context)!.foundAddresses,
            style: const TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          AddressListTile(
              address: const Address(
                  publicKey: "test",
                  privateKey: "test",
                  hash: "N4ZR3fKhTUod34evnEcDQX3i6XufBDU"),
              onButtonClick: () {}),
          const SizedBox(height: 20),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                  ),
                  onPressed: () {},
                  child: Text(AppLocalizations.of(context)!.cancel),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: CustomColors.primaryColor,
                  ),
                  onPressed: () {

                  },
                  child: Text(AppLocalizations.of(context)!.addToWallet),
                ),
              ],
            ),
          ),
        ]));
  }
}
