import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nososova/ui/pages/info/info_page.dart';
import 'package:nososova/ui/pages/main/widgets/default_app_bar.dart';
import 'package:nososova/ui/pages/node/node_page.dart';
import 'package:nososova/ui/pages/wallets/wallets_page.dart';
import 'package:nososova/ui/theme/style/colors.dart';
import 'package:nososova/ui/theme/style/icons_style.dart';

import '../../../generated/assets.dart';
import '../../config/responsive.dart';
import '../../config/size_config.dart';
import 'widgets/side_left_bar.dart';

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
  ];

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const DefaultAppBar(),
      body: Row(
        children: [
          if (Responsive.isDesktop(context)) const SideLeftBarDesktop(),
          Expanded(
            flex: 6,
            child: Platform.isWindows || Platform.isMacOS || Platform.isLinux
                ? Navigator(
                    onGenerateRoute: (settings) {
                      return MaterialPageRoute(
                        builder: (context) => _pages[_selectedIndex],
                      );
                    },
                  )
                : PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    children: _pages,
                  ),
          ),
        ],
      ),
      bottomNavigationBar:  Platform.isWindows || Platform.isMacOS || Platform.isLinux
          ? null : BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 5,
              selectedItemColor: CustomColors.primaryColor,
              items: <BottomNavigationBarItem>[
                bottomItem(Assets.iconsWallet, 0),
                bottomItem(Assets.iconsInfo, 1),
                bottomItem(Assets.iconsNodeI, 2),
              ],
              currentIndex: _selectedIndex,
              onTap: (index) {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.decelerate,
                );
              },
            )
          ,
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
