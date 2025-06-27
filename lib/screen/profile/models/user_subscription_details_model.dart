class SubscriptionResponse {
  final bool? status;
  final String? message;
  final SubscriptionData? data;

  SubscriptionResponse({this.status, this.message, this.data});

  factory SubscriptionResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionResponse(status: json['status'] as bool?, message: json['message'] as String?, data: json['data'] != null ? SubscriptionData.fromJson(json['data'] as Map<String, dynamic>) : null);
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data?.toJson()};
  }
}

class SubscriptionData {
  final int? subscriptionIdPK;
  final int? userIdFK;
  final int? subscriptionPlanIdFK;
  final String? startDate;
  final String? endDate;
  final int? isActive;
  final String? createdAt;
  final String? planName;
  final String? price;
  final String? offerPrice;
  final int? durationDays;

  SubscriptionData({this.subscriptionIdPK, this.userIdFK, this.subscriptionPlanIdFK, this.startDate, this.endDate, this.isActive, this.createdAt, this.planName, this.price, this.offerPrice, this.durationDays});

  factory SubscriptionData.fromJson(Map<String, dynamic> json) {
    return SubscriptionData(subscriptionIdPK: json['subscription_id_PK'] as int?, userIdFK: json['user_id_FK'] as int?, subscriptionPlanIdFK: json['subscription_plan_id_FK'] as int?, startDate: json['start_date'] as String?, endDate: json['end_date'] as String?, isActive: json['is_active'] as int?, createdAt: json['created_at'] as String?, planName: json['plan_name'] as String?, price: json['price'] as String?, offerPrice: json['offer_price'] as String?, durationDays: json['duration_days'] as int?);
  }

  Map<String, dynamic> toJson() {
    return {'subscription_id_PK': subscriptionIdPK, 'user_id_FK': userIdFK, 'subscription_plan_id_FK': subscriptionPlanIdFK, 'start_date': startDate, 'end_date': endDate, 'is_active': isActive, 'created_at': createdAt, 'plan_name': planName, 'price': price, 'offer_price': offerPrice, 'duration_days': durationDays};
  }
}
