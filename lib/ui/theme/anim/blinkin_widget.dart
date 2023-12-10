import 'dart:async';

import 'package:flutter/material.dart';

class BlinkingWidget extends StatefulWidget {
  final Widget widget;
  final bool startBlinking;
  final int duration;

  const BlinkingWidget(
      {super.key,
      required this.widget,
      required this.startBlinking,
      required this.duration});

  @override
  BlinkingIconState createState() => BlinkingIconState();
}

class BlinkingIconState extends State<BlinkingWidget> {
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    if (widget.startBlinking) {
      startBlinking();
    }
  }

  void startBlinking() {
    Timer.periodic(Duration(milliseconds: widget.duration), (timer) {
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
      duration: Duration(milliseconds: widget.duration),
      child: widget.widget,
    );
  }
}
