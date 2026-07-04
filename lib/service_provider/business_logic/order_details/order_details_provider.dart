import 'package:flutter/material.dart';
import '../../data/models/order_model.dart';

class OrderDetailsProvider extends ChangeNotifier {
  final String orderId;
  bool isLoading = true;
  bool isCompleting = false;
  String? errorMessage;
  String? successMessage;
  OrderModel? order;

  OrderDetailsProvider(this.orderId) {
    loadOrderDetails();
  }

  Future<void> loadOrderDetails() async {
    isLoading = true;
    errorMessage = null;
    successMessage = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      order = OrderModel(
        id: orderId,
        description:
            "يوجد تسريب مياه أسفل حوض المطبخ الرئيسي بحاجة لإصلاح سريع وتبديل الأنابيب التالفة.",
        status: "CompletionPending",
        addressText: "دمشق - مشروع دمر - الجزيرة الثالثة",
        customerName: "أحمد العلي",
        customerPhone: "+963912345678",
        createdAt: "منذ ساعتين",
      );
    } catch (_) {
      errorMessage = "فشل في تحميل تفاصيل الطلب";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> completeOrderWithQR(String qrHash) async {
    isCompleting = true;
    errorMessage = null;
    successMessage = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      successMessage = 'تم إنهاء الطلب وتأكيد العملية بنجاح!';
    } catch (_) {
      errorMessage = "رمز الـ QR غير صالح أو ممسوح مسبقاً";
    } finally {
      isCompleting = false;
      notifyListeners();
    }
  }

  void clearMessages() {
    successMessage = null;
    errorMessage = null;
    notifyListeners();
  }
}
