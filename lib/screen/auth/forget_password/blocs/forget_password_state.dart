class ForgetPasswordState {
  final String email;
  final String? emailError;
  final bool isSubmitting;
  final bool isSuccess;

  const ForgetPasswordState({this.email = '', this.emailError, this.isSubmitting = false, this.isSuccess = false});

  ForgetPasswordState copyWith({String? email, String? emailError, bool? isSubmitting, bool? isSuccess}) {
    return ForgetPasswordState(email: email ?? this.email, emailError: emailError, isSubmitting: isSubmitting ?? this.isSubmitting, isSuccess: isSuccess ?? this.isSuccess);
  }
}
