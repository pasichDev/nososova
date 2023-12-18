import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nososova/ui/theme/style/colors.dart';

import '../../l10n/app_localizations.dart';
import '../../models/seed.dart';
import '../../utils/const/network_const.dart';
import '../theme/style/text_style.dart';

class ExtraUtil {
  /// Це в майбутньому замінити..

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
}
