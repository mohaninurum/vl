abstract class SignUpEvent {}

class FullNameChanged extends SignUpEvent {
  final String fullName;
  FullNameChanged(this.fullName);
}

class ReferralCode extends SignUpEvent {
  final String referralCode;
  ReferralCode(this.referralCode);
}

class EmailSignChanged extends SignUpEvent {
  final String email;
  EmailSignChanged(this.email);
}

class MobileChanged extends SignUpEvent {
  final String mobile;
  MobileChanged(this.mobile);
}

class PasswordChangedSign extends SignUpEvent {
  final String password;
  PasswordChangedSign(this.password);
}

class ConfirmPasswordChanged extends SignUpEvent {
  final String confirmPassword;
  ConfirmPasswordChanged(this.confirmPassword);
}

class TogglePasswordVisibilitySign extends SignUpEvent {}

class ToggleConfirmPasswordVisibilitySign extends SignUpEvent {}

class SubmitPressed extends SignUpEvent {
  final context;
  SubmitPressed({this.context});
}
