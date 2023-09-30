import 'package:flutter/material.dart';

class OtherGradientDecoration extends BoxDecoration {
  const OtherGradientDecoration()
      : super(
          gradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Color(0xFF621359), Color(0xFF192052), Color(0xFF135385)],
          ),
        );
}
