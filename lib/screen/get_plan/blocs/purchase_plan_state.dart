abstract class PurchaseState {}

class PurchaseInitial extends PurchaseState {}

class PurchaseLoading extends PurchaseState {}

class PurchaseSuccess extends PurchaseState {}

class PurchaseFailure extends PurchaseState {
  final String error;
  PurchaseFailure({required this.error});
}

class GetOrderIDSuccess extends PurchaseState {
  final String? orderID;
  GetOrderIDSuccess({required this.orderID});
}
