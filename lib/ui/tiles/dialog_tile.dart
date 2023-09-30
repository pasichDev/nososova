import 'package:flutter/material.dart';

Widget buildListTile(IconData iconData, String title, VoidCallback onClick) {
  return ListTile(
    leading: Icon(iconData),
    title: Text(title),
    onTap: onClick,
  );
}
