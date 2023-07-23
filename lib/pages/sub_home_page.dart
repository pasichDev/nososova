import 'package:flutter/material.dart';
import 'package:nososova/screens/custom_button.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../screens/item_wallet_tile.dart';

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
          const CardHeader(),
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
  }
}

class ListWallets extends StatelessWidget {
  const ListWallets({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
        itemCount: 20,
        itemBuilder: (context, index) {
          return WalletListTile(
              walletAddress: 'N3bbDSazRM3AfKJ8st7jxDj8nuPjKEP $index',
              coins: 0.2,
              onButtonClick: () {
                _showBottomSheet(context, 'N3bbDSazRM3AfKJ8st7jxDj8nuPjKEP');
              });
        },
      ),
    );
  }
}

void _showBottomSheet(BuildContext context, String walletAddres) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (BuildContext context) {
      return Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: QrImageView(
              data: walletAddres,
              version: QrVersions.auto,
              size: 200.0,
            )),
        Text(
          walletAddres,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 16),
        ListView(
          shrinkWrap: true,
          children: [
            _buildListItem(Icons.delete, 'Delete', 'Home Screen'),
            _buildListItem(
                Icons.send_rounded, 'Send from this address', 'Home Screen'),
          ],
        ),
      ]);
    },
  );
}

Widget _buildListItem(IconData iconData, String title, String subtitle) {
  return ListTile(
    leading: Icon(iconData),
    title: Text(title),
    onTap: () {
      // Add the action when the list item is tapped
    },
  );
}

class CardHeader extends StatelessWidget {
  const CardHeader({super.key});

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
      child: const SafeArea(
        child: Padding(
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
                      fontSize: 48,
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
    );
  }
}
