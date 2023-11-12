import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/blocs/app_data_bloc.dart';
import 'package:nososova/l10n/app_localizations.dart';

import '../../blocs/events/app_data_events.dart';
import '../../ui/tiles/seed_info_tile.dart';
import '../../ui/tiles/seed_tile.dart';
import '../pages/debug/debug_info_page.dart';
import '../theme/style/text_style.dart';


class DialogInfoNetwork extends StatefulWidget {
  const DialogInfoNetwork({Key? key}) : super(key: key);

  @override
  DialogInfoNetworkState createState() => DialogInfoNetworkState();
}

class DialogInfoNetworkState extends State<DialogInfoNetwork> {
  bool _isNodeListVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppDataBloc, AppDataState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.titleInfoNetwork,
              style: AppTextStyles.dialogTitle,
            ),
            const SizedBox(height: 20),
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
                      return context.read<AppDataBloc>().add(ReconnectSeed());
                    }),
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
              ],
            ),
            if (_isNodeListVisible) ...[SeedInfoTile(nodeInfo: state.node)],
            if (!_isNodeListVisible) ...[
              ListTile(
                leading: const Icon(Icons.bug_report_outlined),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.debugInfo,
                      style: AppTextStyles.itemStyle,
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<DebugInfoPage>(
                      builder: (context) => const DebugInfoPage(),
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      );
    });
  }
}
