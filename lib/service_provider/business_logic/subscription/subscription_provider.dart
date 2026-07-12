import 'package:flutter/material.dart';

class SubscriptionProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isSubmitting = false;
  bool isActive = false;
  String? expiryDate;
  String? pendingTransactionId;
  String? successMessage;
  String? errorMessage;

  Future<void> checkSubscriptionStatus() async {
    isLoading = true;
    errorMessage = null;
    successMessage = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 600));
      isActive = false;
      expiryDate = "2026-06-01";
      pendingTransactionId = null;
    } catch (_) {
      errorMessage = "خطأ في جلب بيانات الاشتراك";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> submitSubscriptionPayment(String transactionId) async {
    isSubmitting = true;
    errorMessage = null;
    successMessage = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      isActive = false;
      expiryDate = "بانتظار تفعيل المسؤول";
      pendingTransactionId = transactionId;
      successMessage = 'تم إرسال رقم المعاملة للإدارة للتفعيل اليدوي!';
    } catch (_) {
      errorMessage = "فشل إرسال رقم المعاملة";
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }

  void clearMessages() {
    successMessage = null;
    errorMessage = null;
    notifyListeners();
  }
}
