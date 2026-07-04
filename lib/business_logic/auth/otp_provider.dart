import 'package:flutter/material.dart';

class OtpProvider extends ChangeNotifier {
  final List<TextEditingController> controllers =
      List.generate(4, (_) => TextEditingController());

  void clearCode() {
    for (final controller in controllers) {
      controller.clear();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
