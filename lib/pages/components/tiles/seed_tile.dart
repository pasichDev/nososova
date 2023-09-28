import 'package:flutter/material.dart';

import '../../../models/seed.dart';
import '../../../utils/network/network_const.dart';

class SeedListItem extends StatelessWidget {
  final Seed seed;
  final VoidCallback moreSeeds;
  final VoidCallback reConnected;
  final bool moreSeedsOn;
  final bool isNodeListVisible;
  final int statusConnected;

  const SeedListItem({
    super.key,
    required this.seed,
    required this.moreSeeds,
    required this.reConnected,
    this.moreSeedsOn = false,
    required this.isNodeListVisible,
    this.statusConnected = StatusConnectNodes.statusLoading,
  });

  final TextStyle _smallTextSize = const TextStyle(fontSize: 12.0);

  Widget _descriptions() {
    if (statusConnected == StatusConnectNodes.statusLoading) {
      return const Text(
        "Підключення..",
        style: TextStyle(fontSize: 12.0),
      );
    } else {
      if (seed.online) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Status: Connected",
              style: _smallTextSize,
            ),
            const SizedBox(width: 5),
            Text(
              "Ping: ${seed.ping.toString()} ms",
              style: _smallTextSize,
            )
          ],
        );
      } else {
        return const Text(
          "Помилка при підключені, натисніть щоб спробувати ще раз",
          style: TextStyle(fontSize: 12.0, color: Colors.redAccent),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.computer),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                seed.toTokenizer(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              _descriptions(),
            ],
          ),
          if (moreSeedsOn)
            IconButton(
              icon: isNodeListVisible
                  ? const Icon(Icons.expand_less)
                  : const Icon(Icons.expand_more),
              onPressed: () {
                moreSeeds();
              },
            ),
        ],
      ),
      onTap: () {
        if (!seed.online) {
          reConnected();
        }
      },
    );
  }
}
