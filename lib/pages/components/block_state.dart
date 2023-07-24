import 'package:flutter/material.dart';

class BlockState extends StatelessWidget {
  const BlockState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Text(
              ' Block : 120148',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            )
          ],
        ));
  }
}
