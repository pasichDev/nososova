import 'package:flutter/material.dart';

import '../style/colors.dart';

class CardDecoration extends BoxDecoration {
  const CardDecoration()
      : super(
          gradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xFF070F46),
              Color(0xFF0C1034),
              Color(0xFF0E1342),
              Color(0xFF621359),
              Color(0xFF560D4E),
            ],
          ),
          color: CustomColors.primaryNoso,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20)),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFF1C203F),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(6, 6),
            ),
          ],
        );
}
