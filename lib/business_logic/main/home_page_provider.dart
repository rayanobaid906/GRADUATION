import 'package:flutter/material.dart';

class HomePageProvider extends ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => _currentPage;

  final List<Map<String, dynamic>> benefits = [
    {
      "title": "استقبل عروض الأسعار",
      "desc": "أنشئ طلب صيانة ودع الفنيين المتخصصين يقدمون عروضهم",
      "icon": Icons.local_offer_rounded,
      "bg": const Color(0xFF1E293B),
    },
    {
      "title": "خصوصية وأمان تام",
      "desc": "رقم هاتفك محمي تماماً ولا يظهر للطرف الآخر إلا بعد قبولك",
      "icon": Icons.shield_rounded,
      "bg": const Color(0xFF1E2640),
    },
    {
      "title": "إغلاق ذكي بالـ QR",
      "desc": "تأكيد إنهاء العمل والدفع يتم بأمان تام بمجرد مسح رمز الـ QR",
      "icon": Icons.qr_code_scanner_rounded,
      "bg": const Color(0xFF2E1B28),
    },
  ];

  final List<Map<String, dynamic>> services = [
    {"name": "كهرباء", "icon": Icons.bolt_rounded, "color": Colors.amber},
    {"name": "سباكة", "icon": Icons.water_drop_rounded, "color": Colors.blue},
    {"name": "أجهزة منزلية", "icon": Icons.kitchen_rounded, "color": Colors.orange},
    {"name": "تكييف وتبريد", "icon": Icons.ac_unit_rounded, "color": Colors.cyan},
  ];

  void setCurrentPage(int page) {
    if (_currentPage != page) {
      _currentPage = page;
      notifyListeners();
    }
  }
}
