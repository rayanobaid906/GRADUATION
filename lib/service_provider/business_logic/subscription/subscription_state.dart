abstract class SubscriptionState {}

class SubscriptionInitial extends SubscriptionState {}
class SubscriptionLoading extends SubscriptionState {}

class SubscriptionStatusLoaded extends SubscriptionState {
  final bool isActive;
  final String? expiryDate;
  final String? pendingTransactionId;

  SubscriptionStatusLoaded({
    required this.isActive,
    this.expiryDate,
    this.pendingTransactionId,
  });
}

class SubscriptionSubmitting extends SubscriptionState {}
class SubscriptionSubmitSuccess extends SubscriptionState {}
class SubscriptionSubmitFailure extends SubscriptionState {
  final String message;
  SubscriptionSubmitFailure(this.message);
}