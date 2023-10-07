import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/database/database.dart';
import 'package:nososova/ui/tiles/dialog_tile.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../../blocs/events/wallet_events.dart';
import '../../../../../blocs/wallet_bloc.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../utils/noso/parse.dart';
import '../../../../theme/style/colors.dart';

class AddressInfo extends StatefulWidget {
  final Address address;

  const AddressInfo({Key? key, required this.address}) : super(key: key);

  @override
  AddressInfoState createState() => AddressInfoState();
}

class AddressInfoState extends State<AddressInfo> {
  late WalletBloc walletBloc;
  int selectedOption = 1;

  AddressInfoState({
    Key? key,
  });

  @override
  void initState() {
    super.initState();
    walletBloc = BlocProvider.of<WalletBloc>(context);
  }

  // TODO: Внести правльний колір QRCode бо в темні темі будуть трабли
  // TODO: Проблема  відоюраження елемнтів, потрібно без прокрутки
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: QrImageView(
          data: selectedOption == 1
              ? widget.address.hash
              : NosoParse.getQrKeys(widget.address),
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
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
        ],
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: widget.address.hash));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.copy,
                  size: 14,
                ),
                const SizedBox(width: 5),
                Text(
                  widget.address.hash,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 5),
      Expanded(
        child:SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
          children: [
            buildListTile(Icons.confirmation_num_outlined,
                AppLocalizations.of(context)!.certificate, () {}),
            buildListTile(Icons.send_outlined,
                AppLocalizations.of(context)!.sendFromAddress, () {}),
            buildListTile(
                Icons.lock_outline, AppLocalizations.of(context)!.lock, () {}),
            buildListTile(
                Icons.delete_outline, AppLocalizations.of(context)!.delete, () {
              walletBloc.add(DeleteAddress(widget.address));
              Navigator.pop(context);
            })
          ],
        ),
        ),
      ),
    ]);
  }
}
