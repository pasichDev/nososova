import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/ui/theme/style/colors.dart';

import '../../../blocs/node_bloc.dart';
import '../../../l10n/app_localizations.dart';
import '../../dialogs/dialog_info_network.dart';
import '../../pages/info/screen/widget_info_coin.dart';
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
      child: SingleChildScrollView(child: Padding(
          padding: EdgeInsets.all(10),
          child:  Column(
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
                          headerContent(),
                        ]),
                  )),



            ],
          ))),
    );
  }

  headerContent() {
    return BlocBuilder<NodeBloc, NodeState>(builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.available,
                        style: AppTextStyles.itemStyle
                            .copyWith(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        state.stateNode.nodes.length.toString(),
                        style: AppTextStyles.walletAddress
                            .copyWith(color: Colors.white, fontSize: 22),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.launched,
                        style: AppTextStyles.itemStyle
                            .copyWith(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        state.stateNode.launchedNodes.toString(),
                        style: AppTextStyles.walletAddress
                            .copyWith(color: Colors.white, fontSize: 22),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.rewardNodeLaunched,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.itemStyle
                      .copyWith(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 5),
                Text(
                  "${state.stateNode.rewardDay.toStringAsFixed(6)} NOSO",
                  style: AppTextStyles.walletAddress
                      .copyWith(color: Colors.white, fontSize: 22),
                )
              ],
            ),
          )
        ],
      );
    });
  }
}
