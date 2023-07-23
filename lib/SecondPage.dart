import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Друга сторінка'),
      ),
      body: Center(
        child: Text('Це друга сторінка'),
      ),
    );
  }
}