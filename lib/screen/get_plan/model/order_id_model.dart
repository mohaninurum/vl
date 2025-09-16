class OrderResponse {
  final bool status;
  final String message;
  final OrderData? data;

  OrderResponse({required this.status, required this.message, this.data});

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(status: json['status'] ?? false, message: json['message'] ?? '', data: json['data'] != null ? OrderData.fromJson(json['data']) : null);
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data?.toJson()};
  }
}

class OrderData {
  final int amount;
  final int amountDue;
  final int amountPaid;
  final int attempts;
  final int createdAt;
  final String currency;
  final String entity;
  final String id;
  final List<dynamic> notes;
  final String? offerId;
  final String? receipt;
  final String status;

  OrderData({required this.amount, required this.amountDue, required this.amountPaid, required this.attempts, required this.createdAt, required this.currency, required this.entity, required this.id, required this.notes, this.offerId, this.receipt, required this.status});

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(amount: json['amount'] ?? 0, amountDue: json['amount_due'] ?? 0, amountPaid: json['amount_paid'] ?? 0, attempts: json['attempts'] ?? 0, createdAt: json['created_at'] ?? 0, currency: json['currency'] ?? '', entity: json['entity'] ?? '', id: json['id'] ?? '', notes: json['notes'] ?? [], offerId: json['offer_id'], receipt: json['receipt'], status: json['status'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'amount': amount, 'amount_due': amountDue, 'amount_paid': amountPaid, 'attempts': attempts, 'created_at': createdAt, 'currency': currency, 'entity': entity, 'id': id, 'notes': notes, 'offer_id': offerId, 'receipt': receipt, 'status': status};
  }
}
