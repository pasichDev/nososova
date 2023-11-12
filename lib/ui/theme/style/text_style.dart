import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextStyle dialogTitle = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
      fontFamily: "GilroyBold"
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 16.0,
    color: Colors.grey,
  );

  static const TextStyle categoryStyle =
      TextStyle(fontSize: 24.0, color: Colors.black, fontFamily: "GilroyBold");

  static const TextStyle titleMax =
      TextStyle(fontSize: 40.0, color: Colors.white, fontFamily: "GilroyBold");

  static TextStyle titleMin = TextStyle(
      fontSize: 26.0,
      color: Colors.white.withOpacity(0.7),
      fontFamily: "GilroyBold");

  static TextStyle blockStyle = const TextStyle(
      fontSize: 16.0, color: Colors.white, fontFamily: "GilroyBold");

  static TextStyle walletAddress = const TextStyle(
      fontSize: 18.0,
      color: Colors.black,
      fontFamily: "GilroySemiBold");

  static TextStyle itemStyle = const TextStyle(
      fontSize: 18.0,
      color: Colors.black,
      fontFamily: "GilroyRegular");


}
