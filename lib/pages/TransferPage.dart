import 'package:flutter/material.dart';

class TransferPage extends StatelessWidget {
  const TransferPage({super.key});

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