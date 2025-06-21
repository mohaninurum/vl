class LoginResponse {
  final bool status;
  final String? message;
  final User? user;

  LoginResponse({required this.status, required this.message, this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(status: json['status'] ?? false, message: json['message'] ?? '', user: json['user'] != null ? User.fromJson(json['user']) : null); //json['data'] ?? json['user'];json['user']
  }
}

class User {
  final String? userId;
  final String? fullName;
  final String? email;
  final String? mobile;
  final String? token;

  User({required this.userId, required this.fullName, required this.email, required this.mobile, required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(userId: json['user_id'].toString(), fullName: json['full_name'] ?? '', email: json['email'] ?? '', mobile: json['mobile'].toString(), token: json['token'] ?? '');
  }
}
