import 'package:flutter/material.dart';
import 'package:nososova/ui/theme/style/colors.dart';

import '../../../dialogs/dialog_wallet_actions.dart';

class SideRightBarDesktop extends StatelessWidget {
  const SideRightBarDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: CustomColors.secondaryBg,
        child: const Padding(
            padding: EdgeInsets.all(10),
            child: Card(
              color: Colors.white,
              child: DialogWalletActions(),
            )));
  }
}
