import 'package:flutter/material.dart';
import '../../data/models/order_model.dart';

class AvailableOrdersProvider extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  String? successMessage;
  bool offerSubmitted = false;
  List<OrderModel> orders = [];

  Future<void> fetchAvailableOrders() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      orders = [
        OrderModel(
          id: "101",
          description:
              "يوجد تسريب مياه أسفل حوض المطبخ الرئيسي بحاجة لإصلاح سريع وتبديل الأنابيب التالفة.",
          status: "Open",
          addressText: "دمشق - مشروع دمر - الجزيرة الثالثة",
          createdAt: "منذ 10 دقائق",
        ),
        OrderModel(
          id: "102",
          description:
              "صيانة وتغيير خلاط مياه الحمام التالف بالكامل مع الفحص العام.",
          status: "Open",
          addressText: "دمشق - الميدان - بالقرب من جامع الحسن",
          createdAt: "منذ ساعة",
        ),
      ];
    } catch (_) {
      errorMessage = "فشل تحميل الطلبات المتاحة";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> submitOffer({
    required String orderId,
    required double priceToCheck,
    required String note,
  }) async {
    isLoading = true;
    errorMessage = null;
    successMessage = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 800));
      offerSubmitted = true;
      await fetchAvailableOrders();
      successMessage = 'تم إرسال عرض الفحص الخاص بك بنجاح!';
    } catch (_) {
      errorMessage = "فشل إرسال عرض السعر للعميل";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearMessages() {
    errorMessage = null;
    successMessage = null;
    notifyListeners();
  }

  void clearOfferSubmission() {
    offerSubmitted = false;
    notifyListeners();
  }
}
