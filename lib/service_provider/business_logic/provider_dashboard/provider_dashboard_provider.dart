import 'package:flutter/material.dart';

class ProviderDashboardProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index) {
    if (_selectedIndex == index) return;
    _selectedIndex = index;
    notifyListeners();
  }

  void onBottomNavTap(int index) {
    setSelectedIndex(index);
  }
}
