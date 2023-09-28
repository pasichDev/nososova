import 'package:flutter/material.dart';
import 'package:nososova/blocs/wallet_bloc.dart';
import 'package:nososova/database/database.dart';
import 'package:nososova/pages/components/tiles/item_dialog.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AddressInfo extends StatelessWidget {
  final Address address;
  final WalletBloc walletBloc;
  const AddressInfo({
    Key? key,
    required this.address,
    required this.walletBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: QrImageView(
            data: address.hash,
            version: QrVersions.auto,
            size: 200.0,
          )),
      Text(
        address.hash,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      const SizedBox(height: 16),
      ListView(
        shrinkWrap: true,
        children: [
          buildListItem(Icons.delete, 'Delete', () {
            walletBloc.add(DeleteAddress(address));
            Navigator.pop(context);
          }),
          buildListItem(Icons.send_rounded, 'Send from this address', () {}),
        ],
      ),
    ]);
  }
}
