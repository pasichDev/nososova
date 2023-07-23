import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Troe сторінка'),
      ),
      body: Center(
        child: Text('Troeсторінка'),
      ),
    );
  }
}