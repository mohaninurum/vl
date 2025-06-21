abstract class LoginEvent {}

class EmailChanged extends LoginEvent {
  final String email;
  EmailChanged(this.email);
}

class PasswordChanged extends LoginEvent {
  final String password;
  PasswordChanged(this.password);
}

class TogglePasswordVisibility extends LoginEvent {}

class LoginSubmitted extends LoginEvent {
  final context;
  LoginSubmitted(this.context);
}

class GoogleSignInEvent extends LoginEvent {
  final context;
  GoogleSignInEvent(this.context);
}

class GoogleLogOutEvent extends LoginEvent {
  final context;
  GoogleLogOutEvent(this.context);
}

class GoogleIsLoginEvent extends LoginEvent {
  final context;
  String? displayName;
  String? email;
  String? providerId;
  String? signInMethod;
  GoogleIsLoginEvent({this.context, this.displayName, this.email, this.signInMethod, this.providerId});
}
