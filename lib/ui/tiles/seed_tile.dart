import 'package:flutter/material.dart';
import 'package:nososova/ui/theme/style/text_style.dart';

import '../../../l10n/app_localizations.dart';
import '../../../models/seed.dart';
import '../../utils/const/network_const.dart';
import '../../utils/custom_class/shimmer.dart';

class SeedListItem extends StatelessWidget {
  final Seed seed;
  final bool isNodeListVisible;
  final StatusConnectNodes statusConnected;

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
        style: AppTextStyles.itemStyle.copyWith(fontSize: 14),
      );
    } else {
      if (seed.online) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.activeConnect,
              style: AppTextStyles.itemStyle.copyWith(fontSize: 14),
            ),
            const SizedBox(width: 5),
            Text(
              "(${seed.ping.toString()} ${AppLocalizations.of(context)!.pingMs})",
              style: AppTextStyles.itemStyle.copyWith(fontSize: 14),
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
        CheckConnect.getStatusConnected(statusConnected),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (statusConnected == StatusConnectNodes.statusLoading)
                Container(
                  margin: EdgeInsets.zero,
                  child: ShimmerPro.sized(
                    depth: 10,
                    scaffoldBackgroundColor: Colors.grey.shade100,
                    width: 150,
                    borderRadius: 1,
                    height: 14,

                  ),
                )
              else
                Column(
                  children: [
                    Text(
                      seed.toTokenizer(),
                      style: AppTextStyles.walletAddress.copyWith(fontSize: 16),
                    ),
                  ],
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
