import '../models/subscription_plan_model.dart';

abstract class SubscriptionState {}

class InitialSubscriptionState extends SubscriptionState {}

class SelectSubscriptionState extends SubscriptionState {
  final int selectedPlanIndex;
  SelectSubscriptionState({this.selectedPlanIndex = 0});
}

class IsLoadingSubscriptionState extends SubscriptionState {}

class SubscriptionPlanListState extends SubscriptionState {
  final int selectedPlanIndex;
  final String? subscriptionID;
  final SubscriptionPlanResponse? subscriptionPlanResponse;
  SubscriptionPlanListState({this.subscriptionID, this.subscriptionPlanResponse, this.selectedPlanIndex = -1});
}

class FailSubscriptionState extends SubscriptionState {}
