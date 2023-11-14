import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/blocs/app_data_bloc.dart';
import 'package:nososova/ui/theme/style/text_style.dart';
import 'package:nososova/utils/const/network_const.dart';

class NetworkInfo extends StatelessWidget {
  final VoidCallback nodeStatusDialog;

  const NetworkInfo({
    super.key,
    required this.nodeStatusDialog,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppDataBloc, AppDataState>(builder: (context, state) {
      return OutlinedButton(
          onPressed: () => nodeStatusDialog(),
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            backgroundColor: Colors.white.withOpacity(0.1),
            elevation: 0
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                CheckConnect.getStatusConnected(state.statusConnected),
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              if (state.statusConnected == StatusConnectNodes.connected || state.statusConnected == StatusConnectNodes.sync)
                Text(state.node.lastblock.toString(),
                    style: AppTextStyles.blockStyle)
            ],
          ));
    });
  }
}
