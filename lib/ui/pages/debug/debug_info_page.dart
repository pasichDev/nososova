import 'package:flutter/material.dart';

class DebugInfoPage extends StatefulWidget {
  const DebugInfoPage({super.key});
  @override
  QRScanScreenState createState() => QRScanScreenState();
}

class QRScanScreenState extends State<DebugInfoPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Debug Info'),
      ),


    );
  }

}
