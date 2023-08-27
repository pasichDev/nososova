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
        return Scaffold(
          appBar: null,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CardHeader(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Wallets',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [

                        Icon(
                          Icons.add_rounded, // Replace with the desired icon
                          size: 24.0, // Adjust the size as needed
                          color: Colors.blue, // Adjust the color as needed
                        ),
                        SizedBox(width: 10.0), // Adding some spacing between the icons
                        Icon(
                          Icons.label_important_outline_rounded, // Replace with the desired icon
                          size: 24.0, // Adjust the size as needed
                          color: Colors.blue, // Adjust the color as needed
                        ),
                        SizedBox(width: 10.0), // Adding some spacing between the icons
                        Icon(
                          Icons.import_export_rounded, // Replace with the desired icon
                          size: 24.0, // Adjust the size as needed
                          color: Colors.blue, // Adjust the color as needed
                        ),
                      ],
                    ),
                  ],
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
