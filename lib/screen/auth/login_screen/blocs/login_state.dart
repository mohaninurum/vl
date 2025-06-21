// class LoginState {
//   final String email;
//   final String? emailError;
//   final String password;
//   final String? passwordError;
//   final bool isPasswordShow;
//
//   LoginState({this.email = '', this.emailError, this.password = '', this.passwordError, required this.isPasswordShow});
//
//   LoginState copyWith({String? email, String? emailError, String? password, String? passwordError, required bool isPasswordShow}) {
//     return LoginState(email: email ?? this.email, emailError: emailError, password: password ?? this.password, passwordError: passwordError, isPasswordShow: isPasswordShow);
//   }
// }
class LoginState {
  final String email;
  final String password;
  final String? emailError;
  final String? passwordError;
  final bool isPasswordVisible;
  final bool isSubmitting;
  final bool isSubmitGoogle;
  final bool isSuccess;
  final bool isLogin;
  final String? generalError;

  const LoginState({this.isSubmitGoogle = false, this.isLogin = false, this.email = '', this.password = '', this.emailError, this.passwordError, this.isPasswordVisible = false, this.isSubmitting = false, this.isSuccess = false, this.generalError});

  LoginState copyWith({bool? isSubmitGoogle, bool? isLogin, String? email, String? password, String? emailError, String? passwordError, bool? isPasswordVisible, bool? isSubmitting, bool? isSuccess, String? generalError}) {
    return LoginState(isSubmitGoogle: isSubmitGoogle ?? this.isSubmitGoogle, isLogin: isLogin ?? this.isLogin, email: email ?? this.email, password: password ?? this.password, emailError: emailError, passwordError: passwordError, isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible, isSubmitting: isSubmitting ?? this.isSubmitting, isSuccess: isSuccess ?? this.isSuccess, generalError: generalError);
  }
}
