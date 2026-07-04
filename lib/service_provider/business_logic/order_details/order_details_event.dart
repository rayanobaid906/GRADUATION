abstract class OrderDetailsEvent {}

class LoadOrderDetails extends OrderDetailsEvent {
  final String orderId;
  LoadOrderDetails(this.orderId);
}

class CompleteOrderWithQR extends OrderDetailsEvent {
  final String orderId;
  final String qrHash;
  CompleteOrderWithQR({required this.orderId, required this.qrHash});
}