abstract class SubscriptionEvent {}

class SelectPlan extends SubscriptionEvent {
  final int planIndex; // 0 or 1
  SelectPlan(this.planIndex);
}
