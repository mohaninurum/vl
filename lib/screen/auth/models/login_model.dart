// class LoginResponse {
//   final bool? status;
//   final String? message;
//   final User? user;
//
//   LoginResponse({this.status, this.message, this.user});
//
//   factory LoginResponse.fromJson(Map<String, dynamic> json) {
//     return LoginResponse(status: json['status'] as bool?, message: json['message'] as String?, user: json['user'] != null ? User.fromJson(json['user']) : null);
//   }
// }
//
// class User {
//   final int? userId;
//   final String? fullName;
//   final String? email;
//   final String? mobile;
//   final int? isSubscribe;
//   final String? expiryDate;
//   final String? token;
//
//   User({this.userId, this.fullName, this.email, this.mobile, this.isSubscribe, this.expiryDate, this.token});
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       userId: json['user_id'] as int?,
//       fullName: json['full_name'] as String?,
//       email: json['email'] as String?,
//       mobile: json['mobile'] as String?,
//       isSubscribe: json['is_subscribe'] as int?,
//       expiryDate: json['expiry_date'] as String?, // can be null
//       token: json['token'] as String?,
//     );
//   }
// }
class LoginResponse {
  final bool status;
  final String message;
  final User? user;

  LoginResponse({required this.status, required this.message, this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(status: json['status'] ?? false, message: json['message'] ?? '', user: json['user'] != null ? User.fromJson(json['user']) : null);
  }
}

class User {
  final int userId;
  final String fullName;
  final String email;
  final String mobile;
  final String? referralCode;
  final int isSubscribe;
  final String? expiryDate;
  final String token;

  User({required this.userId, required this.fullName, required this.email, required this.mobile, this.referralCode, required this.isSubscribe, this.expiryDate, required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(userId: json['user_id'] ?? 0, fullName: json['full_name'] ?? '', email: json['email'] ?? '', mobile: json['mobile'] ?? '', referralCode: json['referral_code'], isSubscribe: json['is_subscribe'] ?? 0, expiryDate: json['expiry_date'], token: json['token'] ?? '');
  }
}
