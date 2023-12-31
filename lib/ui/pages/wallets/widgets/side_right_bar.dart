import 'package:flutter/material.dart';
import 'package:nososova/ui/theme/style/colors.dart';

import '../../../dialogs/dialog_info_network.dart';
import '../../../dialogs/dialog_wallet_actions.dart';

class SideRightBarDesktop extends StatelessWidget {
  const SideRightBarDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370,
      height: double.infinity,
      color: CustomColors.barBg,
      child: const SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Card(child: DialogInfoNetwork()),
                  //       const SizedBox(height: 10),
                  SizedBox(height: 10),
                  Card(
                    color: Colors.white,
                    child: DialogWalletActions(),
                  )
                ],
              ))),
    );
  }
}
