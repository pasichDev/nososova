import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/ui/tiles/dialog_tile.dart';

import '../../../../../blocs/events/wallet_events.dart';
import '../../../../../blocs/wallet_bloc.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../utils/noso/src/address_object.dart';
import '../../../../dialogs/dialog_view_qr.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      const SizedBox(height: 20),
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
          const SizedBox(width: 10),
          IconButton(
              onPressed: () => _viewQr(context),
              icon: const Icon(Icons.qr_code))
        ],
      ),
      const SizedBox(height: 10),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildListTile(Icons.confirmation_num_outlined,
              AppLocalizations.of(context)!.certificate, () {}),
          buildListTile(Icons.account_balance_wallet_outlined,
              AppLocalizations.of(context)!.billAction, () {}),
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
    ]);
  }

  void _viewQr(BuildContext context) {
    Navigator.pop(context);

    DialogViewQr().loadDialog(context: context, address: widget.address);
  }
}
