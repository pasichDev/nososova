import 'package:flutter/material.dart';
import 'package:nososova/database/database.dart';
import 'package:nososova/pages/home_page_view_model.dart';
import 'package:nososova/pages/wallets/screens/card_header.dart';
import 'package:nososova/pages/wallets/screens/dialogs/dialog_add_wallet.dart';
import 'package:nososova/pages/wallets/screens/dialogs/dialog_more.dart';
import 'package:nososova/pages/wallets/screens/list_wallets.dart';
import 'package:provider/provider.dart';

class WalletsPage extends StatelessWidget {
  WalletsPage({super.key});

  MyDatabase database = MyDatabase();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageViewModel>(
      builder: (context, homeViewModel, _) {
        return Scaffold(
          appBar: null,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CardHeader(),
              Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: const HeaderMyWallets()),
              ListWallets(),
            ],
          ),
        );
      },
    );
  }
}

class HeaderMyWallets extends StatelessWidget {
  const HeaderMyWallets({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'My Wallets',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.wallet, color: Colors.blue),
              onPressed: () {
                _showBottomSheetAddMyWallets(context);
              }
            ),
             IconButton(
              icon: const Icon(Icons.more_horiz, color: Colors.blue),
                onPressed: () {
                  _showBottomSheetMoreMyWallets(context);
                }
            ),
          ],
        ),
      ],
    );
  }
}

void _showBottomSheetAddMyWallets(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return DialogAddWallet();
    },
  );
}

void _showBottomSheetMoreMyWallets(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return const DialogMore();
    },
  );
}
