import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/blocs/app_data_bloc.dart';
import 'package:nososova/l10n/app_localizations.dart';
import 'package:nososova/pages/debug_info_page.dart';

import '../components/tiles/seed_info_tile.dart';
import '../components/tiles/seed_tile.dart';

class DialogInfoNetwork extends StatefulWidget {
  final BuildContext parentContext;

  const DialogInfoNetwork({Key? key, required this.parentContext})
      : super(key: key);

  @override
  DialogInfoNetworkState createState() => DialogInfoNetworkState();
}

class DialogInfoNetworkState extends State<DialogInfoNetwork> {
  bool _isNodeListVisible = false;

  @override
  Widget build(BuildContext context) {
    final appDataBloc = BlocProvider.of<AppDataBloc>(widget.parentContext);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.titleInfoNetwork,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: SeedListItem(
                  seed: appDataBloc.state.seedActive,
                  isNodeListVisible: _isNodeListVisible,
                  statusConnected: appDataBloc.state.statusConnected,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.restart_alt_outlined),
                onPressed: () {
                  appDataBloc.add(ReconnectSeed());
                },
              ),
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
          if (_isNodeListVisible) ...[
            SeedInfoTile(nodeInfo: appDataBloc.state.nodeInfo)
          ],
          if (!_isNodeListVisible) ...[
            ListTile(
              leading: const Icon(Icons.bug_report_outlined),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.debugInfo,
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DebugInfoPage(),
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}
