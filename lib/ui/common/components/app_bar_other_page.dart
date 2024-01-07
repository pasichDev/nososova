import 'package:flutter/material.dart';

import '../../config/responsive.dart';
import 'network_info.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onNodeStatusDialog;
  final bool isWhite;

  const CustomAppBar(
      {super.key, required this.onNodeStatusDialog, this.isWhite = false});


  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ?  AppBar(

      title: NetworkInfo(nodeStatusDialog: onNodeStatusDialog),
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: isWhite ? Colors.black : Colors.white),

      elevation: 0,
    ): const PreferredSize(
      preferredSize: Size.zero,
      child: SizedBox(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
