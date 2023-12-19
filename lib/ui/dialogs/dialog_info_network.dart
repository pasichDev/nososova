import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nososova/blocs/app_data_bloc.dart';
import 'package:nososova/l10n/app_localizations.dart';

import '../../blocs/events/app_data_events.dart';
import '../../ui/tiles/seed_tile.dart';
import '../../utils/const/network_const.dart';
import '../../utils/custom_class/shimmer.dart';
import '../../utils/noso/model/node.dart';
import '../components/extra_util.dart';
import '../config/responsive.dart';
import '../theme/style/text_style.dart';

class DialogInfoNetwork extends StatefulWidget {
  const DialogInfoNetwork({super.key});

  @override
  DialogInfoNetworkState createState() => DialogInfoNetworkState();
}

class DialogInfoNetworkState extends State<DialogInfoNetwork> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppDataBloc, AppDataState>(builder: (context, state) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Text(
                AppLocalizations.of(context)!.titleInfoNetwork,
                style: AppTextStyles.dialogTitle,
              )),
          Row(
            children: [
              Expanded(
                child: SeedListItem(
                  seed: state.node.seed,
                  statusConnected: state.statusConnected,
                ),
              ),
              IconButton(
                  icon: const Icon(Icons.restart_alt_outlined),
                  onPressed: () {
                    return context.read<AppDataBloc>().add(ReconnectSeed(true));
                  }),
              IconButton(
                  icon: const Icon(Icons.navigate_next),
                  onPressed: () {
                    return context
                        .read<AppDataBloc>()
                        .add(ReconnectSeed(false));
                  }),
              const SizedBox(width: 10)
            ],
          ),
          if (!Responsive.isMobile(context)) ...[
            itemInfo(
                AppLocalizations.of(context)!.status,
                ExtraUtil.getNodeDescriptionString(
                    context, state.statusConnected, state.node.seed), StatusConnectNodes.connected)
          ],
          itemInfo(AppLocalizations.of(context)!.nodeType,
              getNetworkType(state.node), state.statusConnected),
          itemInfo(AppLocalizations.of(context)!.lastBlock,
              state.node.lastblock.toString(), state.statusConnected),
          itemInfo(AppLocalizations.of(context)!.version,
              state.node.version.toString(), state.statusConnected),
          itemInfo(AppLocalizations.of(context)!.utcTime,
              getNormalTime(state.node.utcTime), state.statusConnected),
          const SizedBox(height: 20),
        ],
      );
    });
  }

  String getNetworkType(Node node) {
    bool isDev = NetworkConst.getSeedList()
        .any((item) => item.toTokenizer() == node.seed.toTokenizer());
    return isDev ? "Verified node" : "Custom node";
  }

  String getNormalTime(int unixTime) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTime * 1000);
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  itemInfo(String nameItem, String value, StatusConnectNodes statusConnected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            nameItem,
            style: AppTextStyles.itemStyle
                .copyWith(color: Colors.black.withOpacity(0.5), fontSize: 18),
          ),
          if (statusConnected == StatusConnectNodes.searchNode ||
              statusConnected == StatusConnectNodes.sync || statusConnected == StatusConnectNodes.consensus)
            Container(
              margin: EdgeInsets.zero,
              child: ShimmerPro.sized(
                depth: 16,
                scaffoldBackgroundColor:
                Colors.grey.shade100.withOpacity(0.5),
                width: 100,
                borderRadius: 3,
                height: 20,
              ),
            )
          else Text(
            value,
            style: AppTextStyles.walletAddress
                .copyWith(color: Colors.black, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
