import 'package:flutter/material.dart';
import 'package:nososova/ui/theme/style/icons_style.dart';
import 'package:nososova/ui/theme/style/text_style.dart';

Widget buildListTile(IconData iconData, String title, VoidCallback onClick) {
  return ListTile(
    leading: Icon(iconData),
    title: Text(title, style: AppTextStyles.itemStyle),
    onTap: onClick,
  );
}
Widget buildListTileSvg(String iconData, String title, VoidCallback onClick, {bool enabled = true}) {
  return ListTile(
    enabled: enabled,
    leading: AppIconsStyle.icon3x2(iconData, colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn)),
    title: Text(title, style: AppTextStyles.itemStyle),
    onTap: onClick,
  );
}

