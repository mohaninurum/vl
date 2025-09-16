abstract class PurchaseEvent {}

class StartPurchase extends PurchaseEvent {
  final String planId;
  final String userId;
  final String token;
  final context;
  StartPurchase({required this.planId, required this.userId, required this.token, required this.context});
}

class GetOrderID extends PurchaseEvent {
  final String amount;
  final String token;
  final context;
  GetOrderID({required this.amount, required this.token, this.context});
}
