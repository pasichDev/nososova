import 'package:flutter/material.dart';

import '../../utils/const/network_const.dart';
import '../../utils/noso/model/node.dart';
import '../tiles/seed_info_tile.dart';
import '../tiles/seed_tile.dart';

class NodeStatusItem extends StatefulWidget {
  final bool isNodeListVisible;
  final StatusConnectNodes statusConnected;
  final Node node;

  const NodeStatusItem({
    Key? key,
    required this.node,
    required this.isNodeListVisible,
    required this.statusConnected,
  }) : super(key: key);

  @override
  _NodeStatusItemState createState() => _NodeStatusItemState();
}

class _NodeStatusItemState extends State<NodeStatusItem> {
  bool _isNodeListVisible = false; // Початковий стан для внутрішнього стану

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SeedListItem(
                seed: widget.node.seed,
                isNodeListVisible: widget.isNodeListVisible,
                statusConnected: widget.statusConnected,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.restart_alt_outlined),
              onPressed: () {
                // Додайте обробник подій для кнопки restart
                // context.read<AppDataBloc>().add(ReconnectSeed(true));
              },
            ),
            IconButton(
              icon: const Icon(Icons.navigate_next),
              onPressed: () {
                // Додайте обробник подій для кнопки navigate_next
                // context.read<AppDataBloc>().add(ReconnectSeed(false));
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
        if (_isNodeListVisible) ...[SeedInfoTile(nodeInfo: widget.node)],
      ],
    );
  }
}
