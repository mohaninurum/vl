part of 'logout_bloc.dart';

abstract class LogoutEvent {}

class UserLogoutEvent extends LogoutEvent {
  var context;
  UserLogoutEvent(this.context);
}
