import 'package:flutter/material.dart';
import 'package:nososova/ui/theme/anim/blinkin_widget.dart';
import 'package:nososova/ui/theme/style/colors.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../models/address_wallet.dart';
import '../../../theme/style/text_style.dart';

class PendingsWidget extends StatefulWidget {
  final Address address;

  const PendingsWidget({super.key, required this.address});

  @override
  State createState() => _PendingsWidgetState();
}

class _PendingsWidgetState extends State<PendingsWidget> {
  @override
  Widget build(BuildContext context) {
    var isOutgoing = widget.address.outgoing > 0;
    var isIncoming = widget.address.incoming > 0;
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
                        Text(AppLocalizations.of(context)!.incoming,
                            style: AppTextStyles.itemStyle
                                .copyWith(color: Colors.white)),
                        BlinkingWidget(
                            widget: Text(
                                "${isIncoming ? "+" : ""}${widget.address.incoming.toStringAsFixed(6)}",
                                style: AppTextStyles.categoryStyle.copyWith(
                                    fontSize: 18,
                                    color: isIncoming
                                        ? CustomColors.positiveBalance
                                        : Colors.white.withOpacity(0.8))),
                            startBlinking: isIncoming,
                            duration: 1000),
                      ],
                    )),
                const SizedBox(width: 60),
                Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Text(AppLocalizations.of(context)!.outgoing,
                            style: AppTextStyles.itemStyle
                                .copyWith(color: Colors.white)),
                        BlinkingWidget(
                            widget: Text(
                                "${isOutgoing ? "-" : ""}${widget.address.outgoing.toStringAsFixed(6)}",
                                style: AppTextStyles.categoryStyle.copyWith(
                                    fontSize: 18,
                                    color: isOutgoing
                                        ? CustomColors.negativeBalance
                                        : Colors.white.withOpacity(0.8))),
                            startBlinking: isOutgoing,
                            duration: 1000),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}
