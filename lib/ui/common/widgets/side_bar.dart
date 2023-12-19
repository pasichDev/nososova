import 'package:flutter/material.dart';
import 'package:nososova/ui/theme/style/colors.dart';

import '../../../l10n/app_localizations.dart';
import '../../dialogs/dialog_info_network.dart';
import '../../pages/info/screen/widget_info_coin.dart';
import '../../pages/node/screens/body_stats_nodes.dart';
import '../../theme/style/text_style.dart';

class SideBarDesktop extends StatefulWidget {
  const SideBarDesktop({
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _SideBarDesktopState();
}

class _SideBarDesktopState extends State<SideBarDesktop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      color: CustomColors.barBg,
      child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Card(child: DialogInfoNetwork()),
                  const SizedBox(height: 10),
                  const Card(child: WidgetInfoCoin()),
                  const SizedBox(height: 10),
                  Card(
                      color: const Color(0xFF363957),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.informMyNodes,
                                style: AppTextStyles.dialogTitle
                                    .copyWith(color: Colors.white),
                              ),
                              const SizedBox(height: 20),
                              const StatsNodesUser(),
                            ]),
                      )),
                ],
              ))),
    );
  }
}
