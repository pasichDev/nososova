import 'package:flutter/material.dart';

class OtherGradientDecoration extends BoxDecoration {
  const OtherGradientDecoration()
      : super(
          gradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xff1a1106),
              Color(0xFF323657),
              Color(0xFF202348),
              Color(0xFF323654),
              Color(0xFF343756),],
          ),
        );
}
