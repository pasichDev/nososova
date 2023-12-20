import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppIconsStyle {
  static SvgPicture icon3x2(String iconPath,
      {ColorFilter colorFilter =
          const ColorFilter.mode(Colors.grey, BlendMode.srcIn)}) {
    return SvgPicture.asset(iconPath,
        width: 32, height: 32, colorFilter: colorFilter);
  }

  static SvgPicture icon2x4(String iconPath,
      {Color colorCustom = Colors.grey}) {
    return SvgPicture.asset(iconPath,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(colorCustom, BlendMode.srcIn));
  }

  static SvgPicture icon8x0(String iconPath,
      {Color colorCustom = Colors.grey}) {
    return SvgPicture.asset(iconPath,
        width: 80,
        height: 80,
        colorFilter: ColorFilter.mode(colorCustom, BlendMode.srcIn));
  }
}
