abstract class AvailableOrdersEvent {}

class FetchAvailableOrders extends AvailableOrdersEvent {}

class SubmitOfferEvent extends AvailableOrdersEvent {
  final String orderId;
  final double priceToCheck;
  final String? note;

  SubmitOfferEvent({required this.orderId, required this.priceToCheck, this.note});
}