class SubscriptionPlanResponse {
  final bool? status;
  final String? message;
  final List<SubscriptionPlan>? data;

  SubscriptionPlanResponse({this.status, this.message, this.data});

  factory SubscriptionPlanResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlanResponse(status: json['status'] as bool?, message: json['message'] as String?, data: (json['data'] as List<dynamic>?)?.map((e) => SubscriptionPlan.fromJson(e as Map<String, dynamic>)).toList());
  }
}

class SubscriptionPlan {
  final int? planId;
  final String? planName;
  final String? price;
  final String? offerPrice;
  final int? durationDays;
  final int? isActive;
  final String? createdAt;

  SubscriptionPlan({this.planId, this.planName, this.price, this.offerPrice, this.durationDays, this.isActive, this.createdAt});

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlan(planId: json['plan_id_PK'] as int?, planName: json['plan_name'] as String?, price: json['price'] as String?, offerPrice: json['offer_price'] as String?, durationDays: json['duration_days'] as int?, isActive: json['is_active'] as int?, createdAt: json['created_at'] as String?);
  }
}
