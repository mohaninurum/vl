import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CancelSubscriptionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CancelSubscriptionRequested extends CancelSubscriptionEvent {
  final String userId;
  final String token;
  final BuildContext context;

  CancelSubscriptionRequested({required this.userId, required this.token, required this.context});

  @override
  List<Object?> get props => [userId, token, context];
}
