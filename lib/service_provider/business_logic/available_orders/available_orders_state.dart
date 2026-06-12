import '../../data/models/order_model.dart';

abstract class AvailableOrdersState {}

class AvailableOrdersInitial extends AvailableOrdersState {}
class AvailableOrdersLoading extends AvailableOrdersState {}

class AvailableOrdersLoaded extends AvailableOrdersState {
  final List<OrderModel> orders;
  AvailableOrdersLoaded(this.orders);
}

class AvailableOrdersError extends AvailableOrdersState {
  final String message;
  AvailableOrdersError(this.message);
}

class OfferSubmittedSuccess extends AvailableOrdersState {}