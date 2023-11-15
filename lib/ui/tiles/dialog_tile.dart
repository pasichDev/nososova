import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nososova/ui/theme/style/text_style.dart';

Widget buildListTile(IconData iconData, String title, VoidCallback onClick) {
  return ListTile(
    leading: Icon(iconData),
    title: Text(title, style: AppTextStyles.itemStyle),
    onTap: onClick,
  );
}
Widget buildListTileSvg(String iconData, String title, VoidCallback onClick) {
  return ListTile(
    leading: SvgPicture.asset(iconData, height: 32, width: 32,),
    title: Text(title, style: AppTextStyles.itemStyle),
    onTap: onClick,
  );
}

