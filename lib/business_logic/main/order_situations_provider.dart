import 'package:flutter/material.dart';

class OrderSituationsProvider extends ChangeNotifier {
  int _activeTab = 0;

  int get activeTab => _activeTab;

  void setActiveTab(int tabIndex) {
    if (_activeTab == tabIndex) return;
    _activeTab = tabIndex;
    notifyListeners();
  }
}
