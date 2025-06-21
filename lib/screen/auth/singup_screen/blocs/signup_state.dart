class SignUpState {
  final String fullName;
  final String email;
  final String mobile;
  final String? referralCode;
  final String password;
  final String confirmPassword;
  final bool showPassword;
  final bool showConfirmPassword;
  final String? emailError;
  final String? passwordError;
  final String? generalError;
  final bool? isSubmitting;
  final bool? isSuccess;

  bool get isValid => emailError == null && passwordError == null && password == confirmPassword && fullName.isNotEmpty && mobile.isNotEmpty;

  SignUpState({this.referralCode = '', this.isSubmitting, this.isSuccess, this.fullName = '', this.email = '', this.mobile = '', this.password = '', this.confirmPassword = '', this.showPassword = false, this.showConfirmPassword = false, this.emailError, this.passwordError, this.generalError});

  SignUpState copyWith({String? referralCode, bool? isSubmitting, bool? isSuccess, String? fullName, String? email, String? mobile, String? password, String? confirmPassword, bool? showPassword, bool? showConfirmPassword, String? emailError, String? passwordError, String? generalError}) {
    return SignUpState(referralCode: referralCode ?? this.referralCode, isSubmitting: isSubmitting ?? this.isSubmitting, isSuccess: isSuccess ?? this.isSuccess, fullName: fullName ?? this.fullName, email: email ?? this.email, mobile: mobile ?? this.mobile, password: password ?? this.password, confirmPassword: confirmPassword ?? this.confirmPassword, showPassword: showPassword ?? this.showPassword, showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword, emailError: emailError, passwordError: passwordError, generalError: generalError);
  }
}
