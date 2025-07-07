abstract class SubscriptionEvent {}

class SelectPlan extends SubscriptionEvent {
  final int planIndex;
  SelectPlan(this.planIndex);
}

class GetSubscriptions extends SubscriptionEvent {
  final context;
  final token;
  final id;
  final isSubscribe;
  GetSubscriptions({this.isSubscribe, this.id, this.context, this.token});
}
