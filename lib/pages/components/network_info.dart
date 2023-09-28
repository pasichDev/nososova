import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/blocs/app_data_bloc.dart';
import 'package:nososova/utils/network/network_const.dart';

class NetworkInfo extends StatelessWidget {
  final VoidCallback nodeStatusDialog;

  const NetworkInfo({
    super.key,
    required this.nodeStatusDialog,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppDataBloc, AppDataState>(builder: (context, state) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  StatusConnectNodes.getStatusConnected(state.statusConnected),
                  color: Colors.white,
                ),
                onPressed: () {
                  nodeStatusDialog();
                },
              ),
              Text(
                state.nodeInfo.lastblock.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              )
            ],
          ));
    });
  }
}
