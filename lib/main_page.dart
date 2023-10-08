import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/blocs/wallet_bloc.dart';
import 'package:nososova/l10n/app_localizations.dart';
import 'package:nososova/ui/components/network_info.dart';
import 'package:nososova/ui/dialogs/dialog_info_network.dart';
import 'package:nososova/ui/dialogs/dialog_scanner_qr.dart';
import 'package:nososova/ui/pages/node/node_page.dart';
import 'package:nososova/ui/pages/payments/payments_page.dart';
import 'package:nososova/ui/pages/wallets/wallets_page.dart';
import 'package:nososova/ui/theme/style/colors.dart';

import 'blocs/app_data_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        title: NetworkInfo(
            nodeStatusDialog: () => _showDialogInfoNetwork(context)),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                if (Platform.isAndroid || Platform.isIOS)
                  IconButton(
                    icon: const Icon(Icons.qr_code_scanner_outlined),
                    onPressed: () => _showDialogScanQr(context),
                  ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {},
                )
              ],
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: CustomColors.primaryColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.wallet),
            label: AppLocalizations.of(context)!.wallets,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.import_export_outlined),
            label: AppLocalizations.of(context)!.payments,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.computer),
            label: AppLocalizations.of(context)!.node,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _showDialogScanQr(BuildContext context) {
    DialogScannerQr()
        .showDialogScanQr(context, BlocProvider.of<WalletBloc>(context));
  }

  void _showDialogInfoNetwork(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        context: context,
        builder: (_) => BlocProvider.value(
              value: BlocProvider.of<AppDataBloc>(context),
              child: const DialogInfoNetwork(),
            ));
  }
}
