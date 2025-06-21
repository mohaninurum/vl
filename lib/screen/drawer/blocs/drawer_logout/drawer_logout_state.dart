part of 'drawer_logout_bloc.dart';

abstract class DrawerLogoutState {}

final class DrawerLogoutInitial extends DrawerLogoutState {}

final class DrawerLogoutLoading extends DrawerLogoutState {}

final class DrawerLogoutSuccess extends DrawerLogoutState {}

final class DrawerLogoutFailure extends DrawerLogoutState {}
