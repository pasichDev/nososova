import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nososova/ui/components/network_info.dart';
import 'package:nososova/ui/pages/info/info_page.dart';
import 'package:nososova/ui/pages/node/node_page.dart';
import 'package:nososova/ui/pages/settings/settings_page.dart';
import 'package:nososova/ui/pages/wallets/wallets_page.dart';
import 'package:nososova/ui/theme/style/colors.dart';
import 'package:nososova/ui/theme/style/icons_style.dart';

import '../../generated/assets.dart';
import '../common/widgets/side_bar.dart';
import '../config/responsive.dart';
import '../config/size_config.dart';
import '../route/dialog_router.dart';

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

  final PageController _pageController = PageController(); // Add this line

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Responsive.isMobile(context)
          ? AppBar(
              elevation: 0,
              title: NetworkInfo(
                  nodeStatusDialog: () =>
                      DialogRouter.showDialogInfoNetwork(context)),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      if (Platform.isAndroid || Platform.isIOS)
                        IconButton(
                          icon: AppIconsStyle.icon3x2(Assets.iconsScan,
                              colorFilter: const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn)),
                          onPressed: () =>
                              DialogRouter.showDialogScanQr(context),
                        ),
                    ],
                  ),
                ),
              ],
              backgroundColor: Colors.transparent,
            )
          : const PreferredSize(
              preferredSize: Size.zero,
              child: SizedBox(),
            ),
      body: Row(
        children: [
          if (!Responsive.isMobile(context)) const SideBarDesktop(),
          Expanded(
              child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            children: _pages,
          )),
        ],
      ),
      bottomNavigationBar: Responsive.isMobile(context)
          ? BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 5,
              selectedItemColor: CustomColors.primaryColor,
              items: <BottomNavigationBarItem>[
                bottomItem(Assets.iconsWallet, 0),
                bottomItem(Assets.iconsInfo, 1),
                bottomItem(Assets.iconsNodeI, 2),
              //  bottomItem(Assets.iconsMore, 3),
              ],
              currentIndex: _selectedIndex,
              onTap: (index) {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              },
            )
          : null,
    );
  }

  BottomNavigationBarItem bottomItem(String icon, int index) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: AppIconsStyle.icon3x2(icon,
            colorFilter: ColorFilter.mode(
                _selectedIndex == index
                    ? CustomColors.primaryColor
                    : Colors.grey,
                BlendMode.srcIn)),
      ),
      label: "",
    );
  }
}