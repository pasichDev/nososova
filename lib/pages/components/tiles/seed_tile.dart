import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../models/seed.dart';
import '../../../utils/network/network_const.dart';

class SeedListItem extends StatelessWidget {
  final Seed seed;
  final bool isNodeListVisible;
  final int statusConnected;

  const SeedListItem({
    super.key,
    required this.seed,
    required this.isNodeListVisible,
    this.statusConnected = StatusConnectNodes.statusLoading,
  });

  final TextStyle _smallTextSize = const TextStyle(fontSize: 12.0);

  Widget _descriptions(BuildContext context) {
    if (statusConnected == StatusConnectNodes.statusLoading) {
      return Text(
        AppLocalizations.of(context)!.connection,
        style: _smallTextSize,
      );
    } else {
      if (seed.online) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.activeConnect,
              style: _smallTextSize,
            ),
            const SizedBox(width: 5),
            Text(
              "(${seed.ping.toString()} ${AppLocalizations.of(context)!.pingMs})",
              style: _smallTextSize,
            )
          ],
        );
      } else {
        return Text(
          AppLocalizations.of(context)!.errorConnection,
          style: const TextStyle(fontSize: 12.0, color: Colors.redAccent),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        StatusConnectNodes.getStatusConnected(statusConnected),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                seed.toTokenizer(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              _descriptions(context),
            ],
          ),
        ],
      ),
      onTap: null,
    );
  }
}
