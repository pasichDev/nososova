import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nososova/blocs/app_data_bloc.dart';
import 'package:nososova/ui/theme/style/icons_style.dart';
import 'package:nososova/ui/theme/style/text_style.dart';
import 'package:nososova/utils/network_const.dart';

class NetworkInfo extends StatelessWidget {
  final VoidCallback nodeStatusDialog;

  const NetworkInfo({
    super.key,
    required this.nodeStatusDialog,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppDataBloc, AppDataState>(builder: (context, state) {
      return TextButton(
          onPressed: () => nodeStatusDialog(),
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide.none,
              ),
              backgroundColor: Colors.white.withOpacity(0.1),
              elevation: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (state.statusConnected == StatusConnectNodes.sync ||
                  state.statusConnected == StatusConnectNodes.searchNode) ...[
                LoadingAnimationWidget.flickr(
                  size: 24,
                  leftDotColor: Colors.white.withOpacity(0.5),
                  rightDotColor: Colors.white,
                )
              ] else ...[
                AppIconsStyle.icon2x4(
                    CheckConnect.getStatusConnected(state.statusConnected),
                    colorCustom: Colors.white)
              ],
              if (state.statusConnected == StatusConnectNodes.connected ||
                  state.statusConnected == StatusConnectNodes.sync || state.statusConnected == StatusConnectNodes.consensus) ...[
                const SizedBox(width: 10),
                Text(state.node.lastblock.toString(),
                    style: AppTextStyles.blockStyle)
              ]
            ],
          ));
    });
  }
}
