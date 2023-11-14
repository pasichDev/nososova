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
    this.statusConnected = StatusConnectNodes.searchNode,
  });


  Widget _descriptions(BuildContext context) {
    if (statusConnected == StatusConnectNodes.error) {
     return Text(
          AppLocalizations.of(context)!.errorConnection,
          style: const TextStyle(fontSize: 12.0, color: Colors.redAccent),
        );

    }else if(statusConnected == StatusConnectNodes.searchNode){
      return Text(
        AppLocalizations.of(context)!.connection,
        style: AppTextStyles.itemStyle.copyWith(fontSize: 14),
      );
    }else if(statusConnected == StatusConnectNodes.sync){
      return Text(
        AppLocalizations.of(context)!.sync,
        style: AppTextStyles.itemStyle.copyWith(fontSize: 14),
      );
    }
    if(statusConnected == StatusConnectNodes.connected){
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
    }

    return Container();
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
              if (statusConnected == StatusConnectNodes.searchNode || statusConnected == StatusConnectNodes.sync)
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
