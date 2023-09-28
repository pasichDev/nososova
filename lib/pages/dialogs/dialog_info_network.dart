import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nososova/blocs/app_data_bloc.dart';
import 'package:nososova/l10n/app_localizations.dart';
import 'package:nososova/pages/debug_info_page.dart';

import '../components/seed_info_card.dart';
import '../components/tiles/seed_tile.dart';

class DialogInfoNetwork extends StatefulWidget {
  final BuildContext parentContext;

  const DialogInfoNetwork({Key? key, required this.parentContext}) : super(key: key);

  @override
  _DialogInfoNetworkState createState() => _DialogInfoNetworkState();
}

class _DialogInfoNetworkState extends State<DialogInfoNetwork> {

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
            SeedInfoCard(nodeInfo : appDataBloc.state.nodeInfo)
          ],
        //  if (!_isNodeListVisible) ...[
            ListTile(
              leading: const Icon(Icons.bug_report_outlined),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.debugInfo,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  //        const Icon(Icons.navigate_next_outlined)
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
       //   ]
        ],
      ),
    );
  }

  String getNormalTime(int unixTime) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTime * 1000);
    return DateFormat('HH:mm:ss').format(dateTime);
  }
}

class TagWidget extends StatelessWidget {
  final String text;

  const TagWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
