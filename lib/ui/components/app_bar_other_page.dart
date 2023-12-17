import 'package:flutter/material.dart';

import 'network_info.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onNodeStatusDialog;
  final bool isWhite;

  const CustomAppBar(
      {super.key, required this.onNodeStatusDialog, this.isWhite = false});


  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: NetworkInfo(nodeStatusDialog: onNodeStatusDialog),
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: isWhite ? Colors.black : Colors.white),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
