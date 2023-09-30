import 'package:flutter/material.dart';
import 'package:nososova/database/database.dart';
import 'package:nososova/l10n/app_localizations.dart';

class AddressListTile extends StatelessWidget {
  final VoidCallback onButtonClick;
  final Address address;
  final TextStyle _smallTextSize = const TextStyle(fontSize: 12.0);

  const AddressListTile(
      {super.key, required this.address, required this.onButtonClick});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.wallet),
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(address.hash.toString()),
          const SizedBox(height: 5),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              "${AppLocalizations.of(context)!.incoming}: 0",
              style: _smallTextSize,
            ),
            const SizedBox(width: 5),
            Text(
              "${AppLocalizations.of(context)!.outgoing}: 0",
              style: _smallTextSize,
            )
          ])
        ]),
        const Text(
          "0",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        )
      ]),
      onTap: onButtonClick,
    );
  }
}
