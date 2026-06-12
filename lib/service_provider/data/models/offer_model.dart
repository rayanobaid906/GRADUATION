class OfferModel {
  final String? id;
  final String orderId;
  final String providerId;
  final double priceToCheck;
  final String? note;
  final String status;

  OfferModel({
    this.id,
    required this.orderId,
    required this.providerId,
    required this.priceToCheck,
    this.note,
    this.status = 'Pending',
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'providerId': providerId,
      'priceToCheck': priceToCheck,
      'note': note,
      'status': status,
    };
  }
}