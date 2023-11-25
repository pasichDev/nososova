import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BlinkingIcon extends StatefulWidget {
  String icon;

  BlinkingIcon({super.key, required this.icon});

  @override
  BlinkingIconState createState() => BlinkingIconState();
}

class BlinkingIconState extends State<BlinkingIcon> {
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    startBlinking();
  }

  void startBlinking() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          _isVisible = !_isVisible;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: SvgPicture.asset(
        widget.icon,
        width: 32,
        height: 32,
        color: Colors.grey,
      ),
    );
  }
}
