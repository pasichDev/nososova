import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../l10n/app_localizations.dart';
import '../../utils/noso/src/address_object.dart';
import '../theme/style/colors.dart';

class DialogViewQr {
  void loadDialog({BuildContext? context, required Address address}) {
    assert(context != null);

    showDialog(
        context: context!,
        builder: (context) => Container(
              alignment: Alignment.center,
              child: Container(
                height: 400,
                width: 600,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DialogViewQrWidget(address: address),
              ),
            ));
  }
}

class DialogViewQrWidget extends StatefulWidget {
  late Address address;

  DialogViewQrWidget({super.key, required this.address});

  @override
  ScannerWidgetState createState() => ScannerWidgetState();
}

class ScannerWidgetState extends State<DialogViewQrWidget> {
  int selectedOption = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: QrImageView(
            data: selectedOption == 1
                ? widget.address.hash
                : "${widget.address.publicKey} ${widget.address.privateKey}",
            version: QrVersions.auto,
            size: 300.0,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedOption = 1;
                });
              },
              child: OutlinedButton(
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
                child: Text(
                  AppLocalizations.of(context)!.address,
                  style: TextStyle(
                    fontSize: 14,
                    color: selectedOption == 1
                        ? Colors.white
                        : CustomColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedOption = 2;
                });
              },
              child: OutlinedButton(
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
                child: Text(
                  AppLocalizations.of(context)!.keys,
                  style: TextStyle(
                    fontSize: 14,
                    color: selectedOption == 2
                        ? Colors.white
                        : CustomColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Додайте кнопку "Закрити" тут
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: const Icon(
                  Icons.close,
                  color: CustomColors.primaryColor,
                  size: 24.0,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
