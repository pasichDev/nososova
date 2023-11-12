import 'package:flutter/material.dart';
import 'package:nososova/ui/theme/style/text_style.dart';

Widget buildListTile(IconData iconData, String title, VoidCallback onClick) {
  return ListTile(
    leading: Icon(iconData),
    title: Text(title, style: AppTextStyles.itemStyle),
    onTap: onClick,
  );
}
