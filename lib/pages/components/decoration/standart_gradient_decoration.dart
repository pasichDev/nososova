import 'package:flutter/material.dart';

class StandartGradientDecoration extends BoxDecoration {
  const StandartGradientDecoration()
      : super(
          gradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Color(0xFF621359), Color(0xFF192052), Color(0xFF135385)],
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        );
}
