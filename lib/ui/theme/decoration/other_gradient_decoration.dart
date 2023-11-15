import 'package:flutter/material.dart';

class OtherGradientDecoration extends BoxDecoration {
  const OtherGradientDecoration()
      : super(
          gradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xff1a1106),
              Color(0xFF2B2F4F),
              Color(0xFF343756),
              Color(0xFF7177AF)],
          ),
        );
}
