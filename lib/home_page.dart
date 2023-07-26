import 'package:flutter/material.dart';
import 'package:nososova/pages/components/block_state.dart';
import 'package:nososova/pages/home/sub_home_page.dart';
import 'package:nososova/pages/home_page_view_model.dart';
import 'package:nososova/pages/node/node_page.dart';
import 'package:nososova/pages/payments/payments_page.dart';
import 'package:provider/provider.dart';




class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const SubHomePage(),
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
    return ChangeNotifierProvider<HomePageViewModel>(
      create: (context) => HomePageViewModel(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          title:  BlockState(),
          actions: [
            IconButton(
              icon: const Icon(Icons.computer),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
          backgroundColor: Colors.transparent,
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.payments_outlined),
              label: 'Payments',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.computer),
              label: 'Node',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
