abstract class SubscriptionEvent {}

class SelectPlan extends SubscriptionEvent {
  final int planIndex;
  SelectPlan(this.planIndex);
}
