import 'package:flutter/material.dart';
import 'package:nososova/database/database.dart';
import 'package:nososova/l10n/app_localizations.dart';
import 'package:nososova/ui/theme/style/colors.dart';

import '../pages/wallets/screens/item_wallet_tile.dart';
import '../theme/style/text_style.dart';

typedef OnCancelButtonPressed = void Function();
typedef OnAddToWalletButtonPressed = void Function();

class DialogSearchAddress extends StatelessWidget {
  final Address addressObject;
  final OnCancelButtonPressed onCancelButtonPressed;
  final OnAddToWalletButtonPressed onAddToWalletButtonPressed;

  const DialogSearchAddress({
    Key? key,
    required this.addressObject,
    required this.onCancelButtonPressed,
    required this.onAddToWalletButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            AppLocalizations.of(context)!.foundAddresses,
            style: AppTextStyles.dialogTitle,
          ),
          const SizedBox(height: 20),
          AddressListTile(
              address: addressObject,
              onButtonClick: () {}),
          const SizedBox(height: 20),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  onPressed: () {
                    onCancelButtonPressed();
                    Navigator.pop(context);
                  },
                  child: Text(AppLocalizations.of(context)!.cancel),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.primaryColor,
                  ),
                  onPressed: () {
                    onAddToWalletButtonPressed();
                    Navigator.pop(context);
                  },
                  child: Text(AppLocalizations.of(context)!.addToWallet),
                ),
              ],
            ),
          ),
        ]));
  }
}
