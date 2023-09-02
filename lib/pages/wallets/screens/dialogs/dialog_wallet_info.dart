import 'package:flutter/material.dart';
import 'package:nososova/blocs/data_bloc.dart';
import 'package:nososova/database/database.dart';
import 'package:nososova/pages/components/item_dialog.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AddressInfo extends StatelessWidget {
  final Address address;
  final DataBloc dataBloc;
  const AddressInfo({
    Key? key,
    required this.address,
    required this.dataBloc,
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
            dataBloc.add(DeleteWallet(address));
            Navigator.pop(context);
          }),
          buildListItem(Icons.send_rounded, 'Send from this address', () {}),
        ],
      ),
    ]);
  }
}
