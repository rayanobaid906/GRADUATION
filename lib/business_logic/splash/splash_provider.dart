import 'dart:async';
import 'package:flutter/material.dart';

class SplashProvider extends ChangeNotifier {
  bool _isComplete = false;
  bool get isComplete => _isComplete;

  void startTimer() {
    Timer(const Duration(seconds: 3), () {
      _isComplete = true;
      notifyListeners();
    });
  }
}
