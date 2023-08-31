import 'package:flutter/material.dart';
import 'package:nososova/const.dart';

class BlockState extends StatelessWidget {
  const BlockState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.computer, color: Colors.white,
              ),
              onPressed: null,
            ),
            Text(
              '12387',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            )
          ],
        ));
  }


  IconData getStatusConnected(int status){
    switch (status) {
      case StatusConnectNodes.statusConnected:
        return Icons.computer;
      case StatusConnectNodes.statusError:
        return Icons.report_gmailerrorred_outlined;
      case StatusConnectNodes.statusLoading:
        return Icons.downloading;
      case StatusConnectNodes.statusNoConnected:
        return Icons.signal_wifi_connected_no_internet_4;
      default:
        return Icons.signal_wifi_connected_no_internet_4;
    }
  }
}
