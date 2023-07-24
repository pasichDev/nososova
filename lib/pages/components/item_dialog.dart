import 'package:flutter/material.dart';

Widget buildListItem(
    IconData iconData, String title, String subtitle, VoidCallback onClick) {
  return ListTile(
    leading: Icon(iconData),
    title: Text(title),
    onTap: onClick,
  );
}
