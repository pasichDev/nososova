import 'package:flutter/material.dart';

class StandartGradientDecoration extends BoxDecoration {
  const StandartGradientDecoration({required borderRadius})
      : super(
          gradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Color(0xFF621359), Color(0xFF192052), Color(0xFF135385)],
          ),
          borderRadius: borderRadius
        );
}
