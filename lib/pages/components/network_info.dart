import 'package:flutter/material.dart';
import 'package:nososova/network/network_const.dart';
import 'package:nososova/pages/dialogs/dialog_set_network.dart';

class NetworkInfo extends StatelessWidget {
  const NetworkInfo({super.key});

  @override
  Widget build(BuildContext context) {
 //   final appState = Provider.of<AppState>(context);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.computer, color: Colors.white,
              ),
              onPressed: () {
                _showBottomSetNetwork(context);
              },
            ),
             Text(
               "",
           //   appState.userNode.lastblock.toString(),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            )
          ],
        ));
  }


  IconData getStatusConnected(int status) {
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


  void _showBottomSetNetwork(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const DialogSetNetwork();
      },
    );
  }
}
