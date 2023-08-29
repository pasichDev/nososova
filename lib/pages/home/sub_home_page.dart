import 'package:flutter/material.dart';
import 'package:nososova/database/database.dart';
import 'package:nososova/pages/home/screens/card_header.dart';
import 'package:nososova/pages/home/screens/dialogs/dialog_add_wallet.dart';
import 'package:nososova/pages/home/screens/list_wallets.dart';
import 'package:nososova/pages/home_page_view_model.dart';
import 'package:provider/provider.dart';

class SubHomePage extends StatelessWidget {

   SubHomePage({super.key});
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
                child:  Row(
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
                          onPressed: () {_showBottomSheetAdd(context);},
                        ),
                        const IconButton(
                          icon: Icon(Icons.more_horiz, color: Colors.blue),
                          onPressed: null,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
               ListWallets(),
            ],
          ),
        );
      },
    );
  }


}
void _showBottomSheetAdd(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return  DialogAddWallet();
    },
  );
}