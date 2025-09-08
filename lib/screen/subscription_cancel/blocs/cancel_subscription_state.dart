import 'package:equatable/equatable.dart';

abstract class CancelSubscriptionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CancelInitial extends CancelSubscriptionState {}

class CancelLoading extends CancelSubscriptionState {}

class CancelSuccess extends CancelSubscriptionState {}

class CancelFailure extends CancelSubscriptionState {
  final String error;

  CancelFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
