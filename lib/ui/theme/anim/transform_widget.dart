import 'dart:async';

import 'package:flutter/material.dart';

class TransformWidget extends StatefulWidget {
  final Widget widget;
  final Function(bool) changer;
  final Function(bool) middleChanger;

  const TransformWidget({Key? key, required this.widget, required this.changer, required this.middleChanger})
      : super(key: key);

  @override
  TransformWidgetState createState() => TransformWidgetState();
}

class TransformWidgetState extends State<TransformWidget> {
  double _rotationValue = 0.0;
  double _scaleValue = 1.0;
  double _stepTransformation = 0.01;
  int _duration = 2;
  Timer? _timer;

  bool middleChanger = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void rotationRight() {
    _timer = Timer.periodic(Duration(milliseconds: _duration), (Timer t) {
      if (mounted) {
        setState(() {
          if (_rotationValue < 3.1) {
            _rotationValue += _stepTransformation;
            _scaleChange(1.5);
            if(_rotationValue > 1.5 && !middleChanger){
              middleChanger = true;
              widget.middleChanger(true);
            }
          } else {
            _scaleValue = 1.0;
            widget.changer(true);
            _timer?.cancel();
          }
        });
      }
    });
  }

  void rotationLeft() {
    _timer = Timer.periodic(Duration(milliseconds: _duration), (Timer t) {
      if (mounted) {
        setState(() {
          if (_rotationValue < 6.3) {
            _rotationValue += _stepTransformation;
            _scaleChange(4.6);
            if(_rotationValue > 4.6 && middleChanger){
              middleChanger = false;
              widget.middleChanger(false);
            }
          } else {
            _rotationValue = 0.0;
            _scaleValue = 1.0;
            widget.changer(false);
            _timer?.cancel();
          }
        });
      }
    });
  }

  _scaleChange(double rotationDec) {
    if (_rotationValue <= rotationDec) {
      if (_scaleValue > 0.75) {
        _scaleValue -= 0.005;
      }
    } else {
      if (_scaleValue < 1) {
        _scaleValue += 0.0015;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (mounted) {
          setState(() {
            if (_rotationValue > 3) {
              rotationLeft();
            } else {
              rotationRight();
            }
          });
        }
      },
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(-_rotationValue)
          ..scale(_scaleValue)
          ..rotateX(-0.0),
        alignment: Alignment.topCenter,
        child: widget.widget,
      ),
    );
  }
}
