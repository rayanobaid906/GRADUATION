class ProviderProfileModel {
  final String? id;
  final String userId;
  final String specializationId;
  final String? bio;
  final bool isActiveSubscription;

  ProviderProfileModel({
    this.id,
    required this.userId,
    required this.specializationId,
    this.bio,
    this.isActiveSubscription = false,
  });

  factory ProviderProfileModel.fromJson(Map<String, dynamic> json) {
    return ProviderProfileModel(
      id: json['id'],
      userId: json['userId'],
      specializationId: json['specializationId'],
      bio: json['bio'],
      isActiveSubscription: json['isActiveSubscription'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'specializationId': specializationId,
      'bio': bio,
      'isActiveSubscription': isActiveSubscription,
    };
  }
}