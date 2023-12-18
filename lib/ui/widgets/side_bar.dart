import 'package:flutter/material.dart';
import 'package:nososova/ui/theme/style/colors.dart';

import '../dialogs/dialog_info_network.dart';

class SideBarDesktop extends StatefulWidget {
  const SideBarDesktop({
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _SideBarDesktopState();
}

class _SideBarDesktopState extends State<SideBarDesktop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      color: CustomColors.barBg,
      child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(child: DialogInfoNetwork()),
            ],
          )),
    );
  }
}
