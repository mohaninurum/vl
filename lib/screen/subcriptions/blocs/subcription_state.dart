import '../models/subscription_plan_model.dart';

abstract class SubscriptionState {}

class InitialSubscriptionState extends SubscriptionState {}

class SelectSubscriptionState extends SubscriptionState {
  final int selectedPlanIndex;
  SelectSubscriptionState({this.selectedPlanIndex = 0});
}

class SubscriptionPlanListState extends SubscriptionState {
  final bool isloading;
  final SubscriptionPlanResponse? subscriptionPlanResponse;
  SubscriptionPlanListState({required this.isloading, this.subscriptionPlanResponse});
}
