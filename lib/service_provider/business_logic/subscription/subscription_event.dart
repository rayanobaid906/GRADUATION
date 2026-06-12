abstract class SubscriptionEvent {}

class CheckSubscriptionStatus extends SubscriptionEvent {}

class SubmitSubscriptionPayment extends SubscriptionEvent {
  final String transactionId;
  SubmitSubscriptionPayment({required this.transactionId});
}