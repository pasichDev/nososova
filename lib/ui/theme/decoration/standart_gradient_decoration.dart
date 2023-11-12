import 'package:flutter/material.dart';

class HomeGradientDecoration extends BoxDecoration {
  const HomeGradientDecoration({required borderRadius})
      : super(
            gradient: const LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xFF621359),
                Color(0xFF560D4E),
                Color(0xFF070F46),
                Color(0xFF0C1034)
              ],
            ),
            borderRadius: borderRadius);
}
