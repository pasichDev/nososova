import 'package:flutter/material.dart';
import 'package:nososova/pages/home/screens/action_button.dart';
import 'package:nososova/pages/home/screens/header_info.dart';

class CardHeader extends StatelessWidget {

  int totalBalance = 0;

  CardHeader({super.key, required this.totalBalance});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Color(0xFF621359), Color(0xFF192052), Color(0xFF135385)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child:  SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Overall on balance',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    totalBalance.toString(),
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    ' NOSO',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),
              const HeaderInfo(),
              const Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),
                  child: ActionsButtonList()),
            ],
          ),
        ),
      ),
    );
  }
}
