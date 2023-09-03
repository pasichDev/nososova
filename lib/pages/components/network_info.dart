import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/blocs/app_data_bloc.dart';
import 'package:nososova/pages/dialogs/dialog_set_network.dart';
import 'package:nososova/utils/network/network_const.dart';

class NetworkInfo extends StatelessWidget {

  const NetworkInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppDataBloc, AppDataState>(
        builder: (context, state) {
           return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.computer, color: Colors.white,
                ),
                onPressed: () {
                  _showBottomSetNetwork(context, state);
                },
              ),
              Text(
                state.nodeInfo.lastblock.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              )
            ],
          ));
    });
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


  void _showBottomSetNetwork(BuildContext context, AppDataState state) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return  DialogSetNetwork(state: state);
      },
    );
  }
}
