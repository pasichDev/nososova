import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppIconsStyle {
  static SvgPicture icon3x2(String iconPath) {
    return SvgPicture.asset(iconPath,
        width: 32,
        height: 32,
        colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn));
  }
  static SvgPicture icon2x4(String iconPath, {Color colorCustom = Colors.grey}) {
    return SvgPicture.asset(iconPath,
        width: 32,
        height: 32,
        colorFilter:  ColorFilter.mode(colorCustom, BlendMode.srcIn));
  }
}
