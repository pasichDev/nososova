import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nososova/blocs/app_data_bloc.dart';
import 'package:nososova/l10n/app_localizations.dart';
import 'package:nososova/pages/debug_info_page.dart';

class DialogSetNetwork extends StatefulWidget {
  final AppDataState state;

  DialogSetNetwork({Key? key, required this.state}) : super(key: key);

  @override
  _DialogSetNetworkState createState() => _DialogSetNetworkState();
}

class _DialogSetNetworkState extends State<DialogSetNetwork> {
  bool _isNodeListVisible = false;

  final TextStyle _smallTextSize = const TextStyle(fontSize: 12.0);

  @override
  Widget build(BuildContext context) {
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
              TagWidget(text: "Block : ${widget.state.nodeInfo.lastblock}"),
              const SizedBox(width: 8.0),
              const SizedBox(width: 8.0),
              TagWidget(
                  text: "Time : ${getNormalTime(widget.state.nodeInfo.utcTime)}")
            ],
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.computer),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.state.nodeInfo.seed.ip}:${widget.state.nodeInfo.seed.port.toString()}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Status: Connected",
                          style: _smallTextSize,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Ping: ${widget.state.nodeInfo.seed.ping.toString()} ms",
                          style: _smallTextSize,
                        )
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: _isNodeListVisible
                      ? Icon(Icons.expand_less)
                      : Icon(Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      _isNodeListVisible = !_isNodeListVisible;
                    });
                  },
                ),
              ],
            ),
            onTap: () {
              // Handle tap on the node item if needed.
            },
          ),
          if (_isNodeListVisible) ...[
            // Display the list of nodes when _isNodeListVisible is true.
            // Replace this with your node list widgets.
            ListTile(
              title: Text('Node 1'), // Replace with actual node data
              onTap: () {
                // Handle tap on node item.
              },
            ),
            ListTile(
              title: Text('Node 2'), // Replace with actual node data
              onTap: () {
                // Handle tap on node item.
              },
            ),
          ],

    if (!_isNodeListVisible)...[ ListTile(
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
