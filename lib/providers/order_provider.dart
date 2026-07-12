import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:graduation/models/specialization_model.dart';
import 'package:graduation/services/api_services.dart';
import 'package:graduation/models/order_model.dart';
class OrderProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();

  List<SpecializationModel> specializations = [];

  bool isLoadingSpecializations = false;

  String? errorMessage;
  bool isCreatingOrder = false;
  String? createOrderError;

Future<void> getSpecializations() async {
  try {
    debugPrint('START GET SPECIALIZATIONS');

    isLoadingSpecializations = true;
    errorMessage = null;
    notifyListeners();

    specializations = await apiService.getSpecializations();

    debugPrint('SPECIALIZATIONS COUNT: ${specializations.length}');
  } catch (e) {
    debugPrint('SPECIALIZATIONS ERROR: $e');
    errorMessage = 'فشل في تحميل الطلبات';
  } finally {
    isLoadingSpecializations = false;
    notifyListeners();
  }
}

Future<bool> createOrder({
  required int specializationId,
  required String description,
  required double latitude,
  required double longitude,
  required String addressText,
}) async {
  try {
    isCreatingOrder = true;
    createOrderError = null;
    notifyListeners();

    await apiService.createOrder(
      specializationId: specializationId,
      description: description,
      latitude: latitude,
      longitude: longitude,
      addressText: addressText,
    );

    return true;
  } catch (e) {
  if (e is DioException) {
    debugPrint('CREATE ORDER STATUS: ${e.response?.statusCode}');
    debugPrint('CREATE ORDER DATA: ${e.response?.data}');
    debugPrint('CREATE ORDER MESSAGE: ${e.message}');
  } else {
    debugPrint('CREATE ORDER ERROR: $e');
  }

  createOrderError = 'فشل إنشاء الطلب';
  return false;
} finally {
    isCreatingOrder = false;
    notifyListeners();
  }
}


List<OrderModel> myOrders = [];

bool isLoadingMyOrders = false;

String? myOrdersError;

Future<void> getMyOrders() async {
  try {
    isLoadingMyOrders = true;
    myOrdersError = null;
    notifyListeners();

    myOrders = await apiService.getMyOrders();

    debugPrint('MY ORDERS COUNT: ${myOrders.length}');
  } catch (e) {
  if (e is DioException) {
    debugPrint('MY ORDERS STATUS: ${e.response?.statusCode}');
    debugPrint('MY ORDERS DATA: ${e.response?.data}');
    debugPrint('MY ORDERS MESSAGE: ${e.message}');
  } else {
    debugPrint('MY ORDERS ERROR: $e');
  }

  myOrdersError = 'فشل في تحميل طلباتي';
} 
  
  
   finally {
    isLoadingMyOrders = false;
    notifyListeners();
  }
}
OrderModel? selectedOrder;

bool isLoadingOrderDetails = false;

String? orderDetailsError;

Future<void> getOrderById(int id) async {
  try {
    isLoadingOrderDetails = true;
    orderDetailsError = null;
    notifyListeners();

    selectedOrder = await apiService.getOrderById(id);

    debugPrint('ORDER DETAILS ID: ${selectedOrder?.id}');
  } catch (e) {
    orderDetailsError = 'فشل في تحميل تفاصيل الطلب';
    debugPrint('ORDER DETAILS ERROR: $e');
  } finally {
    isLoadingOrderDetails = false;
    notifyListeners();
  }
}
bool isCancellingOrder = false;
String? cancelOrderError;

Future<bool> cancelOrder(int orderId) async {
  try {
    isCancellingOrder = true;
    cancelOrderError = null;
    notifyListeners();

    await apiService.cancelOrder(orderId);

    await getMyOrders();

    return true;
  } catch (e) {
    cancelOrderError = 'فشل إلغاء الطلب';
    debugPrint('CANCEL ORDER ERROR: $e');

    return false;
  } finally {
    isCancellingOrder = false;
    notifyListeners();
  }
}

}

