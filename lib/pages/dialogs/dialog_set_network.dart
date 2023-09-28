import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nososova/blocs/app_data_bloc.dart';
import 'package:nososova/l10n/app_localizations.dart';
import 'package:nososova/pages/debug_info_page.dart';

import '../components/tiles/seed_tile.dart';

class DialogSetNetwork extends StatefulWidget {
 // final AppDataState state;
  final BuildContext parentContext;

  const DialogSetNetwork({Key? key, required this.parentContext}) : super(key: key);

  @override
  _DialogSetNetworkState createState() => _DialogSetNetworkState();
}


///Реалізувати перепідключення


class _DialogSetNetworkState extends State<DialogSetNetwork> {


  //late AppDataBloc appDataBloc;
  bool _isNodeListVisible = false;



  @override
  Widget build(BuildContext context) {
    final appDataBloc = BlocProvider.of<AppDataBloc>(widget.parentContext);

 //   appDataBloc.add(FetchNodesList());
    final nodesList = appDataBloc.state.nodesList;


  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.titleSetNetwork,
            style: const TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              TagWidget(text: "Block : ${appDataBloc.state.nodeInfo.lastblock}"),
              const SizedBox(width: 8.0),
              TagWidget(
                  text:
                      "Time : ${getNormalTime(appDataBloc.state.nodeInfo.utcTime)}")
            ],
          ),
          const SizedBox(height: 20),
          SeedListItem(
           seed: appDataBloc.state.seedActive,
            moreSeeds: () {
              setState(() {
                _isNodeListVisible = !_isNodeListVisible;
              });
            },
            reConnected: (){
             // appDataBloc.add(ReconnectSeed());
            },
            moreSeedsOn: true,
            isNodeListVisible: _isNodeListVisible,
            statusConnected: appDataBloc.state.statusConnected,
          ),
          if (_isNodeListVisible) ...[
            ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 0.0),
                itemCount: nodesList.length,
                itemBuilder: (context, index) {
                  final node = nodesList[index];
                  return ListTile(title: Text(node.toTokenizer()));
                })
          ],
          if (!_isNodeListVisible) ...[
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
          ]
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
