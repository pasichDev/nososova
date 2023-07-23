import 'package:flutter/material.dart';
import 'package:nososova/components/CustomButton.dart';

import '../components/WalletListTile.dart';

class SubHomePage extends StatelessWidget {
  const SubHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Color(0xFF621359),
                  Color(0xFF192052),
                  Color(0xFF135385)
                ],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const SafeArea( child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Overall on balance',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '20,888',
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        ' NOSO',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: CustomButtonList()),
                ],
              ),
            ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: const Text(
              'My Wallets',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
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
