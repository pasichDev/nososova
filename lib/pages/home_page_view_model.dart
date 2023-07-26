import 'package:flutter/foundation.dart';

class HomePageViewModel extends ChangeNotifier  {
  int _totalBalance = 0;
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;
  int get totalBalance => _totalBalance;

  void updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
