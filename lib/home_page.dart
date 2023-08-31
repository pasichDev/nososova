import 'package:flutter/material.dart';
import 'package:nososova/l10n/app_localizations.dart';
import 'package:nososova/pages/components/network_info.dart';
import 'package:nososova/pages/node/node_page.dart';
import 'package:nososova/pages/payments/payments_page.dart';
import 'package:nososova/pages/qr_scan_page.dart';
import 'package:nososova/pages/wallets/wallets_page.dart';
import 'package:nososova/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const WalletsPage(),
    const PaymentsPage(),
    const NodePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(extendBodyBehindAppBar: true,
      appBar: AppBar(elevation: 0,
        title: const NetworkInfo(),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner_outlined), onPressed: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => const QRScanScreen())
            );
          },),
          IconButton(icon: const Icon(Icons.settings), onPressed: () {},),
        ],
        backgroundColor: Colors.transparent,),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: CustomColors.primaryColor,
        items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: const Icon(Icons.wallet),
          label: AppLocalizations.of(context)!.wallets,),
        BottomNavigationBarItem(icon: const Icon(Icons.import_export_outlined),
          label: AppLocalizations.of(context)!.payments,),
        BottomNavigationBarItem(icon: const Icon(Icons.computer),
          label: AppLocalizations.of(context)!.node,),
      ], currentIndex: _selectedIndex, onTap: _onItemTapped,),);
  }
}
