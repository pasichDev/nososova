import 'package:flutter/material.dart';
import 'package:nososova/ui/theme/style/icons_style.dart';
import 'package:nososova/ui/theme/style/text_style.dart';

import '../../../models/seed.dart';
import '../../utils/const/network_const.dart';
import '../../utils/custom_class/shimmer.dart';
import '../components/extra_util.dart';
import '../config/responsive.dart';

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



  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: AppIconsStyle.icon3x2(CheckConnect.getStatusConnected(statusConnected)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (statusConnected == StatusConnectNodes.searchNode ||
                  statusConnected == StatusConnectNodes.sync)
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
              if (Responsive.isMobile(context)) ...[
                ExtraUtil.getNodeDescription(context, statusConnected, seed)
              ],
            ],
          ),
        ],
      ),
      onTap: null,
    );
  }
}
