import '../../data/models/order_model.dart';

abstract class OrderDetailsState {}

class OrderDetailsInitial extends OrderDetailsState {}
class OrderDetailsLoading extends OrderDetailsState {}

class OrderDetailsLoaded extends OrderDetailsState {
  final OrderModel order;
  OrderDetailsLoaded(this.order);
}

class OrderDetailsError extends OrderDetailsState {
  final String message;
  OrderDetailsError(this.message);
}

class QRSubmitting extends OrderDetailsState {}
class QRSubmitSuccess extends OrderDetailsState {}
class QRSubmitFailure extends OrderDetailsState {
  final String message;
  QRSubmitFailure(this.message);
}