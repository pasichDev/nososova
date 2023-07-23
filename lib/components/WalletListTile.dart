import 'package:flutter/material.dart';

class WalletListTile extends StatelessWidget {
  const WalletListTile({super.key, required Text title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.wallet),
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('N4ZR3fKhTUod34evnEcDQX3i6XufBDU'),
          Text(
            '226 NOSO',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      onTap: () {
        print('Клікнули на ListTile!');
      },
    );
  }
}
