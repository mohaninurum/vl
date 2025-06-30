abstract class PurchaseEvent {}

class StartPurchase extends PurchaseEvent {
  final String planId;
  final String userId;
  final String token;
  final context;
  StartPurchase({required this.planId, required this.userId, required this.token, required this.context});
}
