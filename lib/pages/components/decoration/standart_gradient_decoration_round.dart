import 'package:flutter/material.dart';
import 'package:nososova/pages/components/decoration/standart_gradient_decoration.dart';

class StandartGradientDecorationRound extends StandartGradientDecoration {
  const StandartGradientDecorationRound()
      : super(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        );
}
