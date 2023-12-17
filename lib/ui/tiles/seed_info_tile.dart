import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nososova/utils/noso/model/node.dart';

import '../../../l10n/app_localizations.dart';

class SeedInfoTile extends StatelessWidget {
  final Node nodeInfo;

  const SeedInfoTile({
    super.key,
    required this.nodeInfo,
  });


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.arrow_right),
      title:
      Column(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${AppLocalizations.of(context)!.connections}: ${nodeInfo.connections},',
                style: const TextStyle(fontSize: 12.0)),
            const SizedBox(width: 5),
            Text('${AppLocalizations.of(context)!.lastBlock}: ${nodeInfo.lastblock},',
                style: const TextStyle(fontSize: 12.0)),
            const SizedBox(width: 5),
            Text('${AppLocalizations.of(context)!.pendings}: ${nodeInfo.pendings},',
                style: const TextStyle(fontSize: 12.0)),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${AppLocalizations.of(context)!.branch}: ${nodeInfo.branch},',
                style: const TextStyle(fontSize: 12.0)),
            const SizedBox(width: 5),
            Text('${AppLocalizations.of(context)!.version}: ${nodeInfo.version},',
                style: const TextStyle(fontSize: 12.0)),
            const SizedBox(width: 5),
            Text('${AppLocalizations.of(context)!.utcTime}: ${getNormalTime(nodeInfo.utcTime)}',
                style: const TextStyle(fontSize: 12.0)),
          ],
        ),
      ]),
    );
  }

  String getNormalTime(int unixTime) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTime * 1000);
    return DateFormat('HH:mm:ss').format(dateTime);
  }
}
