import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextStyle dialogTitle = TextStyle(
      fontSize: 22.0,
      color: Colors.black,
      fontFamily: "GilroyBold");

  static const TextStyle bodyText = TextStyle(
    fontSize: 16.0,
    color: Colors.grey,
  );

  static const TextStyle categoryStyle =
      TextStyle(fontSize: 24.0, color: Colors.black, fontFamily: "GilroyBold");

  static const TextStyle titleMax =
      TextStyle(fontSize: 40.0, color: Colors.white, fontFamily: "GilroyBold");

  static TextStyle titleMin = const TextStyle(
      fontSize: 22.0,
      color: Colors.white,
      fontFamily: "GilroyBold");

  static TextStyle blockStyle = const TextStyle(
      fontSize: 16.0, color: Colors.white, fontFamily: "GilroyBold");

  static TextStyle walletAddress = const TextStyle(
      fontSize: 18.0, color: Colors.black, fontFamily: "GilroySemiBold");

  static TextStyle itemStyle = const TextStyle(
      fontSize: 18.0, color: Colors.black, fontFamily: "GilroyRegular");

  static TextStyle textFieldStyle =  const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 18,
    fontFamily: "GilroyBold",
  );
  static TextStyle textFieldHiddenStyle =  const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.grey,
    fontSize: 18,
    fontFamily: "GilroyBold",
  );

}
