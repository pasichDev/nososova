import 'package:flutter/material.dart';
import 'dialogs/dialog_import.dart';

class ItemHeaderInfo extends StatelessWidget {
  final String title, value;

  const ItemHeaderInfo({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
      child: TextButton(
        onPressed: () => {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.withOpacity(0.3),
          padding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 5),
            Text(
              '$title: $value',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 5)
          ],
        ),
      ),
    );
  }
}

class HeaderInfo extends StatelessWidget {
  const HeaderInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
         ItemHeaderInfo(title: 'Price', value: '0.1745345345'),
          ItemHeaderInfo(title: 'Incoming', value: '0.0000000000'),
          ItemHeaderInfo(title: 'Outgoing', value: '0.0000000000'),
        ],
      ),
    );
  }
}
