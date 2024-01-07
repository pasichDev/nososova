import 'package:flutter/material.dart';
import 'package:nososova/ui/config/responsive.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../l10n/app_localizations.dart';
import '../../../models/address_wallet.dart';
import '../../theme/style/colors.dart';
import '../../theme/style/text_style.dart';

class DialogViewQrWidget extends StatefulWidget {
  final Address address;

  const DialogViewQrWidget({super.key, required this.address});

  @override
  State createState() => _ScannerWidgetState();
}

class _ScannerWidgetState extends State<DialogViewQrWidget> {
  int selectedOption = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: QrImageView(
            data: selectedOption == 1
                ? widget.address.hash
                : "${widget.address.publicKey} ${widget.address.privateKey}",
            version: QrVersions.auto,
            size: MediaQuery.of(context).size.height * 0.4,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: selectedOption == 1
                    ? CustomColors.primaryColor
                    : Colors.transparent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  selectedOption = 1;
                });
              },
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(AppLocalizations.of(context)!.address,
                      style: AppTextStyles.walletAddress.copyWith(
                          color: selectedOption == 1
                              ? Colors.white
                              : CustomColors.primaryColor))),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: selectedOption == 2
                    ? CustomColors.primaryColor
                    : Colors.transparent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  selectedOption = 2;
                });
              },
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(AppLocalizations.of(context)!.keys,
                      style: AppTextStyles.walletAddress.copyWith(
                          color: selectedOption == 2
                              ? Colors.white
                              : CustomColors.primaryColor))),
              //    ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        if (Responsive.isMobile(context))
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: CustomColors.negativeBalance,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(AppLocalizations.of(context)!.cancel,
                  style: AppTextStyles.walletAddress
                      .copyWith(color: Colors.white)),
            ),
          ),
      ],
    );
  }
}
