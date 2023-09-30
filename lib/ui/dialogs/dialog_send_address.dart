import 'package:flutter/material.dart';
import 'package:nososova/l10n/app_localizations.dart';
import 'package:nososova/ui/theme/style/colors.dart';

typedef OnCancelButtonPressedSend = void Function();
typedef OnSendButtonPressed = void Function();

class DialogSendAddress extends StatelessWidget {
  final String addressTo;
  final OnCancelButtonPressedSend onCancelButtonPressedSend;
  final OnSendButtonPressed onSendButtonPressed;

  const DialogSendAddress({
    Key? key,
    required this.addressTo,
    required this.onCancelButtonPressedSend,
    required this.onSendButtonPressed,
  }) : super(key: key);

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
                    onCancelButtonPressedSend();
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
                    onSendButtonPressed();
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
