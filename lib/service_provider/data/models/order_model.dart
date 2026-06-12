class OrderModel {
  final String id;
  final String description;
  final String status; // Open, InspectionAccepted, InProgress, CompletionPending, Completed
  final String addressText;
  final String? customerName;
  final String? customerPhone;
  final String createdAt;

  OrderModel({
    required this.id,
    required this.description,
    required this.status,
    required this.addressText,
    this.customerName,
    this.customerPhone,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'].toString(),
      description: json['description'],
      status: json['status'],
      addressText: json['addressText'] ?? '',
      customerName: json['customerName'],
      customerPhone: json['customerPhone'],
      createdAt: json['createdAt'] ?? '',
    );
  }
}