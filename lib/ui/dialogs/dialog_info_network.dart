import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/blocs/app_data_bloc.dart';
import 'package:nososova/l10n/app_localizations.dart';
import 'package:nososova/ui/theme/style/icons_style.dart';

import '../../blocs/events/app_data_events.dart';
import '../../generated/assets.dart';
import '../../ui/tiles/seed_info_tile.dart';
import '../../ui/tiles/seed_tile.dart';
import '../common/widgets/label.dart';
import '../components/extra_util.dart';
import '../config/responsive.dart';
import '../route/dialog_router.dart';
import '../theme/style/text_style.dart';

class DialogInfoNetwork extends StatefulWidget {
  const DialogInfoNetwork({super.key});

  @override
  DialogInfoNetworkState createState() => DialogInfoNetworkState();
}

class DialogInfoNetworkState extends State<DialogInfoNetwork> {
  bool _isNodeListVisible = false;

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
                  isNodeListVisible: _isNodeListVisible,
                  statusConnected: state.statusConnected,
                ),
              ),
              IconButton(
                  icon: const Icon(Icons.restart_alt_outlined),
                  onPressed: () {
                    _isNodeListVisible = false;
                    return context.read<AppDataBloc>().add(ReconnectSeed(true));
                  }),
              IconButton(
                  icon: const Icon(Icons.navigate_next),
                  onPressed: () {
                    _isNodeListVisible = false;
                    return context
                        .read<AppDataBloc>()
                        .add(ReconnectSeed(false));
                  }),
              if (Responsive.isMobile(context))
                IconButton(
                  icon: _isNodeListVisible
                      ? const Icon(Icons.expand_less)
                      : const Icon(Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      _isNodeListVisible = !_isNodeListVisible;
                    });
                  },
                ),
              const SizedBox(width: 10)
            ],
          ),
          if (!Responsive.isMobile(context)) ...[
            Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Row(
                  children: [
                    Label(
                        widget: ExtraUtil.getNodeDescription(
                            context, state.statusConnected, state.node.seed)),
                    const SizedBox(width: 10),
                    Label(text: state.node.lastblock.toString()),
                  ],
                ))
          ],
          if (_isNodeListVisible) ...[SeedInfoTile(nodeInfo: state.node)],
          if (!_isNodeListVisible) ...[
            ListTile(
                //  contentPadding: EdgeInsets.zero,
                leading: AppIconsStyle.icon3x2(Assets.iconsDebugI),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.debugInfo,
                      style: AppTextStyles.itemStyle,
                    ),
                  ],
                ),
                onTap: () => DialogRouter.showDialogDebug(context)),
          ],
          const SizedBox(height: 20),
        ],
      );
    });
  }

  infoNode(String icon, String text) {
    return ListTile(
        leading: AppIconsStyle.icon3x2(icon),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: AppTextStyles.itemStyle,
            ),
          ],
        ),
        onTap: null);
  }
}
