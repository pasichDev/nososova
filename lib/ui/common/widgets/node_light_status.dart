import 'package:flutter/material.dart';
import 'package:nososova/ui/theme/style/text_style.dart';

import '../../../l10n/app_localizations.dart';
import '../../../models/address_wallet.dart';
import '../../theme/anim/blinkin_widget.dart';
import '../../theme/style/colors.dart';

class NodeLightStatus extends StatelessWidget {
  final Address address;

  const NodeLightStatus({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Text(AppLocalizations.of(context)!.status,
                            style: AppTextStyles.itemStyle
                                .copyWith(color: Colors.white)),
                        BlinkingWidget(
                            widget: Text(
                                address.nodeStatusOn
                                    ? AppLocalizations.of(context)!.online
                                    : AppLocalizations.of(context)!.offline,
                                style: AppTextStyles.categoryStyle.copyWith(
                                    fontSize: 18,
                                    color: address.nodeStatusOn
                                        ? CustomColors.positiveBalance
                                        : CustomColors.negativeBalance)),
                            startBlinking: address.nodeStatusOn,
                            duration: 1000),
                      ],
                    )),
                const SizedBox(width: 60),
                Expanded(
                    flex: 2,
                    child: Tooltip(
                        message: AppLocalizations.of(context)!.nr24,
                        child: Column(
                          children: [
                            Text(AppLocalizations.of(context)!.reward,
                                style: AppTextStyles.itemStyle
                                    .copyWith(color: Colors.white)),
                            Text(address.rewardDay.toStringAsFixed(7),
                                style: AppTextStyles.categoryStyle.copyWith(
                                    fontSize: 18,
                                    color: Colors.white.withOpacity(0.8))),
                          ],
                        ))),
              ],
            ),
          ),
        ));
  }
}
