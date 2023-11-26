import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nososova/blocs/debug_bloc.dart';
import 'package:nososova/blocs/wallet_bloc.dart';
import 'package:nososova/ui/components/network_info.dart';
import 'package:nososova/ui/components/widget_internet_connection.dart';
import 'package:nososova/ui/dialogs/dialog_info_network.dart';
import 'package:nososova/ui/dialogs/dialog_scanner_qr.dart';
import 'package:nososova/ui/pages/info/info_page.dart';
import 'package:nososova/ui/pages/node/node_page.dart';
import 'package:nososova/ui/pages/settings/settings_page.dart';
import 'package:nososova/ui/pages/wallets/wallets_page.dart';
import 'package:nososova/ui/theme/style/colors.dart';
import 'package:nososova/ui/theme/style/dialog_style.dart';

import 'blocs/app_data_bloc.dart';
import 'generated/assets.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const WalletsPage(),
    const InfoPage(),
    const NodePage(),
    const SettingsPage(),
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
                    icon: SvgPicture.asset(
                      Assets.iconsScan,
                      height: 28,
                      width: 28,
                      color: Colors.white,
                    ),
                    onPressed: () => _showDialogScanQr(context),
                  ),
              ],
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: _pages[_selectedIndex],
          ),
          const StatusNetworkConnection(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 5,
        selectedItemColor: CustomColors.primaryColor,
        items: <BottomNavigationBarItem>[
          bottomItem(Assets.iconsWallet, 0),
          bottomItem(Assets.iconsInfo, 1),
          bottomItem(Assets.iconsNodeI, 2),
          bottomItem(Assets.iconsMore, 3),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  bottomItem(String icon, int index) {
    return BottomNavigationBarItem(
      icon: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: SvgPicture.asset(
            icon,
            width: 32,
            height: 32,
            color: _selectedIndex == index
                ? CustomColors.primaryColor
                : Colors.grey,
          )),
      label: "",
    );
  }

  void _showDialogScanQr(BuildContext context) {
    DialogScannerQr()
        .showDialogScanQr(context, BlocProvider.of<WalletBloc>(context));
  }

  void _showDialogInfoNetwork(BuildContext context) {
    showModalBottomSheet(
        shape: DialogStyle.borderShape,
        context: context,
        builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: BlocProvider.of<AppDataBloc>(context),
                ),
                BlocProvider.value(
                  value: BlocProvider.of<DebugBloc>(context),
                ),
              ],
              child: const DialogInfoNetwork(),
            ));
  }
}
