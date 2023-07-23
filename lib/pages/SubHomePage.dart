import 'package:flutter/material.dart';

import '../components/WalletListTile.dart';

class SubHomePage extends StatelessWidget {
  const SubHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Color(0xFF621359), Color(0xFF135385), Color(0xFF192052)],
              ),
              borderRadius: BorderRadius.circular(30),

            ),

          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            // Додали відступи
            child: const Text(
              'Мої Рахунки',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
              itemCount: 20,
              // Кількість елементів у списку
              itemBuilder: (context, index) {
                // Повертаємо елемент списку
                return WalletListTile(
                  title: Text('dsnfsdnfisdnfsidfsdfsdfsdfsd $index'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
