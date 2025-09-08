// class SubscriptionPlanResponse {
//   final bool? status;
//   final String? message;
//   final List<SubscriptionPlan>? data;
//
//   SubscriptionPlanResponse({this.status, this.message, this.data});
//
//   factory SubscriptionPlanResponse.fromJson(Map<String, dynamic> json) {
//     return SubscriptionPlanResponse(status: json['status'] as bool?, message: json['message'] as String?, data: (json['data'] as List<dynamic>?)?.map((e) => SubscriptionPlan.fromJson(e as Map<String, dynamic>)).toList());
//   }
// }
//
// class SubscriptionPlan {
//   final int? planId;
//   final String? planName;
//   final String? price;
//   final String? offerPrice;
//   final int? durationDays;
//   final int? isActive;
//   final String? createdAt;
//
//   SubscriptionPlan({this.planId, this.planName, this.price, this.offerPrice, this.durationDays, this.isActive, this.createdAt});
//
//   factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
//     return SubscriptionPlan(planId: json['plan_id_PK'] as int?, planName: json['plan_name'] as String?, price: json['price'] as String?, offerPrice: json['offer_price'] as String?, durationDays: json['duration_days'] as int?, isActive: json['is_active'] as int?, createdAt: json['created_at'] as String?);
//   }
// }
class SubscriptionPlanResponse {
  final bool status;
  final String message;
  final List<SubscriptionPlan> data;

  SubscriptionPlanResponse({required this.status, required this.message, required this.data});

  factory SubscriptionPlanResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlanResponse(status: json['status'] ?? false, message: json['message'] ?? '', data: (json['data'] as List<dynamic>?)?.map((e) => SubscriptionPlan.fromJson(e)).toList() ?? []);
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data.map((e) => e.toJson()).toList()};
  }
}

class SubscriptionPlan {
  final int planId;
  final String planName;
  final String price;
  final String? offerPrice; // nullable
  final int validityUnit;
  final int validityCount;
  final int isActive;
  final String createdAt;

  SubscriptionPlan({required this.planId, required this.planName, required this.price, this.offerPrice, required this.validityUnit, required this.validityCount, required this.isActive, required this.createdAt});

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlan(
      planId: json['plan_id_PK'] ?? 0,
      planName: json['plan_name'] ?? '',
      price: json['price'] ?? '0',
      offerPrice: json['offer_price'], // nullable
      validityUnit: json['validity_unit'] ?? 0,
      validityCount: json['validity_count'] ?? 0,
      isActive: json['is_active'] ?? 0,
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'plan_id_PK': planId, 'plan_name': planName, 'price': price, 'offer_price': offerPrice, 'validity_unit': validityUnit, 'validity_count': validityCount, 'is_active': isActive, 'created_at': createdAt};
  }
}
