part of 'drawer_logout_bloc.dart';

abstract class DrawerLogoutEvent {}

class UserLogoutEvent extends DrawerLogoutEvent {
  var context;
  UserLogoutEvent(this.context);
}
