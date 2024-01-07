import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noso_dart/models/seed.dart';
import 'package:nososova/ui/theme/style/colors.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/network_const.dart';
import '../../theme/style/text_style.dart';

class NodeStatusUi {
  static Widget getNodeDescription(
      BuildContext context, StatusConnectNodes statusConnected, Seed seed) {
    if (statusConnected == StatusConnectNodes.error) {
      return Text(
        AppLocalizations.of(context)!.errorConnection,
        style: AppTextStyles.itemStyle
            .copyWith(fontSize: 14, color: CustomColors.negativeBalance),
      );
    } else if (statusConnected == StatusConnectNodes.searchNode) {
      return Text(
        AppLocalizations.of(context)!.connection,
        style: AppTextStyles.itemStyle.copyWith(fontSize: 14),
      );
    } else if (statusConnected == StatusConnectNodes.sync) {
      return Text(
        AppLocalizations.of(context)!.sync,
        style: AppTextStyles.itemStyle.copyWith(fontSize: 14),
      );
    } else if (statusConnected == StatusConnectNodes.consensus) {
      return Text(
        AppLocalizations.of(context)!.consensusCheck,
        style: AppTextStyles.itemStyle.copyWith(fontSize: 14),
      );
    }
    if (statusConnected == StatusConnectNodes.connected) {
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

  static String getNodeDescriptionString(
    BuildContext context,
    StatusConnectNodes statusConnected,
    Seed seed,
  ) {
    switch (statusConnected) {
      case StatusConnectNodes.error:
        return AppLocalizations.of(context)!.errorConnection;
      case StatusConnectNodes.searchNode:
        return AppLocalizations.of(context)!.connection;
      case StatusConnectNodes.sync:
        return AppLocalizations.of(context)!.sync;
      case StatusConnectNodes.consensus:
        return AppLocalizations.of(context)!.consensusCheck;
      case StatusConnectNodes.connected:
        return '${AppLocalizations.of(context)!.activeConnect} (${seed.ping.toString()} ${AppLocalizations.of(context)!.pingMs})';

      default:
        break;
    }

    return "";
  }
}
