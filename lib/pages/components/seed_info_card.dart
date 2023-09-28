import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nososova/models/node_info.dart';

class SeedInfoCard extends StatelessWidget {
  final NodeInfo nodeInfo;

  const SeedInfoCard({super.key,
    required this.nodeInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Тінь карточки
      margin: const EdgeInsets.all(16), // Відступи
      child: Padding(
        padding: const EdgeInsets.all(16), // Відступи всередині карточки
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Для горизонтального прокручування
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Connections: ${nodeInfo.connections}, '),
              Text('Last Block: ${nodeInfo.lastblock}, '),
              Text('Pendings: ${nodeInfo.pendings}, '),
              Text('Delta: ${nodeInfo.delta}, '),
              Text('Branch: ${nodeInfo.branch}, '),
              Text('Version: ${nodeInfo.version}, '),
              Text('UTC Time: ${ getNormalTime(nodeInfo.utcTime)}'),
            ],
          ),
        ),
      ),
    );
  }

  String getNormalTime(int unixTime) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTime * 1000);
    return DateFormat('HH:mm:ss').format(dateTime);
  }


}
