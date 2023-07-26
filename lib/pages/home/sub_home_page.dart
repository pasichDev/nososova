import 'package:flutter/material.dart';
import 'package:nososova/pages/home/screens/card_header.dart';
import 'package:nososova/pages/home/screens/list_wallets.dart';
import 'package:nososova/pages/home_page_view_model.dart';
import 'package:provider/provider.dart';


class SubHomePage extends StatelessWidget {
  const SubHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageViewModel>(
      builder: (context, homeViewModel, _) {
        // Access the shared ViewModel using homeViewModel
        return Scaffold(
          appBar: null,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               CardHeader(totalBalance : homeViewModel.totalBalance),
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
              const ListWallets(),
            ],
          ),
        );
      },
    );
  }
}
