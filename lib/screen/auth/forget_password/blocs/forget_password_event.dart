abstract class ForgetPasswordEvent {}

class ForgetEmailChanged extends ForgetPasswordEvent {
  final String email;
  ForgetEmailChanged(this.email);
}

class ForgetPasswordSubmitted extends ForgetPasswordEvent {
  final context;
  ForgetPasswordSubmitted(this.context);
}
